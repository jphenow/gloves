require 'spec_helper'
require 'gloves/storage/json_store'

module Gloves
  class Storage
    RSpec.describe JSONStore do
      let(:file_name) { "/tmp/gloves.json" }
      subject { described_class.new file_name }

      after do
        if File.exist?(file_name)
          File.delete(file_name)
        end
      end

      it "responds to correct methods" do
        expect(subject).to respond_to :read
        expect(subject).to respond_to :write
      end

      it "writes and reads" do
        subject.write(:test, { json: "is cool" })
        expect(subject.read(:test)).to eq "json" => "is cool"
      end
    end
  end
end
