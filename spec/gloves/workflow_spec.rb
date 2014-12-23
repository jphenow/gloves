require 'spec_helper'
require 'gloves'

class MyWorkflow < Gloves::Workflow
end

module Gloves
  RSpec.describe MyWorkflow do
    let(:alfred) { double "alfred" }
    let(:alfred_feedback) { double "alfred feedback" }

    before do
      allow(Alfred).to receive(:with_friendly_error).and_yield(alfred)
      allow(alfred).to receive(:feedback) { alfred_feedback }
    end

    it "should run" do
      expect_any_instance_of(MyWorkflow).to receive(:run!)
      described_class.new { }
    end

    describe "with xml input" do
      before do
        allow_any_instance_of(MyWorkflow).to receive(:raw_args) { "<item>asdf</item>" }
        allow(alfred_feedback).to receive(:to_xml) { "" }
      end

      it "shouldn't run" do
        expect_any_instance_of(MyWorkflow).to_not receive(:run!)
        described_class.new { }
      end
    end
  end
end
