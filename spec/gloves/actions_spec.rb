require 'spec_helper'
require 'gloves/actions'

module Gloves
  RSpec.describe Actions do
    let(:feedback) { double "Alfred feedback" }
    let(:action) { Action.new :github }

    subject { described_class.new feedback }

    describe "run based on input" do
      before do
        subject << action
      end

      it "calls on matching action" do
        expect(action).to receive(:called) { -> {} }.twice
        subject.run_from_input("github")
      end

      it "calls on matching action" do
        expect_any_instance_of(Action).to_not receive(:called)
        subject.run_from_input("blahhub")
      end
    end

    describe "building action items" do
      before do
        subject << action
      end

      it "sends items to Alfred feedback" do
        expect(feedback).to receive(:add_item).with(action.output)
        subject.build_items "input"
      end
    end

    describe "adding actions" do
      it "adds actions" do
        expect { subject << action }.to change { subject.actions.count }.by(1)
      end
    end
  end
end
