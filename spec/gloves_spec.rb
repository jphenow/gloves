require 'spec_helper'
require 'gloves'

RSpec.describe Gloves do
  subject { described_class }

  let(:app_class) { double }

  before do
    subject.boot(app_class, "/tmp")
  end

  it "sets environment" do
    expect(subject.environment).to eq "test"
  end

  it "sets root" do
    expect(subject.root).to eq '/tmp'
  end

  it "sets app-class" do
    expect(subject.app_class).to eq app_class
  end
end
