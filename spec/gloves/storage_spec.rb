require 'spec_helper'
require 'gloves/storage'

module Gloves
  RSpec.describe Storage do
    let(:store) { double "store" }
    subject { described_class.new "/tmp" }

    before do
      expect(Storage::JSONStore).to receive(:new).with("/tmp/data.json")
      allow(subject).to receive(:store) { store }
    end

    it "can read from a storage back end" do
      expect(store).to receive(:read)
      subject[:key]
    end

    it "can write to a storage back end" do
      expect(store).to receive(:write).with(:key, :value)
      subject[:key] = :value
    end
  end
end
