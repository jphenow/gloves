require 'spec_helper'
require 'gloves/action'
require 'gloves/feedback'

module Gloves
  RSpec.describe Action do
    subject { described_class.new :github }

    it "receives open" do
      expect(subject).to receive(:`).with("open google.com")
      subject.open "google.com"
    end

    it "attempts to copy to clipboard" do
      expect(IO).to receive(:popen).with('pbcopy', 'w')
      subject.clipboard("test")
    end

    it "notifies" do
      expect(subject).to receive(:`).with(
        "osascript -e 'display notification \"testing 123\" with title \"title\"'"
      )
      subject.notify body: "testing 123", title: "title"
    end
  end
end
