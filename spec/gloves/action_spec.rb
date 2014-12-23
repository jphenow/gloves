require 'spec_helper'
require 'gloves/action'

module Gloves
  RSpec.describe Action do
    let(:name) { :github }
    subject { described_class.new name }

    it "writes output to a hash" do
      expect(subject.output).to eq({
        uid: "github",
        title: "github",
        subtitle: "github",
        arg: "do github",
        valid: "yes"
      })
    end

    it "sets a block" do
      expect(subject.called).to be_nil
    end

    describe "with a block set already" do
      before do
        subject.called { true }
      end

      it "gets a block" do
        expect(subject.called).to be_a(Proc)
      end

      it "can call block" do
        expect(subject.called.call).to be_truthy
      end
    end
  end
end
