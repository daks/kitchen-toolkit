require 'spec_helper'

describe KitchenToolkit::Suite do

  let(:suite) { described_class.new(name: 'base') }

  subject { suite }

  describe '#name' do
    it 'should return suite name' do
      expect(subject.name).to eq 'base'
    end
  end

  describe '#to_s' do
    it 'should return suite name' do
      expect(subject.to_s).to eq 'base'
    end
  end
end
