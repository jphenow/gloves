require 'spec_helper'
require 'alfred'
require 'gloves'

module Gloves
  RSpec.describe Workflow do
    let(:alfred) { double "alfred" }
    let(:alfred_feedback) { double "alfred feedback" }

    subject { described_class }

    before do
      allow(Alfred).to receive(:with_friendly_error).and_yield(alfred)
      allow(alfred).to receive(:feedback) { alfred_feedback }
    end

    it "should run" do
      expect_any_instance_of(described_class).to receive(:run!)
      described_class.new { }
    end

    describe "with xml input" do
      before do
        allow_any_instance_of(described_class).to receive(:raw_args) { "<item>asdf</item>" }
        allow(alfred_feedback).to receive(:to_xml) { "" }
      end

      it "shouldn't run" do
        expect_any_instance_of(described_class).to_not receive(:run!)
        described_class.new { }
      end
    end

    describe "an instance" do
      subject do
        described_class.new(:without_run) do |workflow|
          workflow.action :github do |action|
            action.title = "Github"
            action.subtitle = "Visit github"
            action.called do |runner|
              workflow.clipboard token
              workflow.notify title: "Github",
                body: "Opening Github"
              workflow.open "github.com"
            end
          end
        end
      end

      before do
        allow(alfred_feedback).to receive(:add_item)
        allow(alfred_feedback).to receive(:to_xml)
        allow(alfred).to receive(:storage_path) { "/tmp" }
        allow(subject).to receive(:raw_args) { "github string" }
      end

      it "should have storage" do
        expect(subject.store).to be_a Storage
      end

      it "sets action arguments" do
        expect(subject.action_arguments).to eq(["string"])
      end
    end
  end
end
