require 'spec_helper'

describe KitchenToolkit::Profile do

  describe 'valid KitchenToolkit::Profile' do

    let(:profile) { described_class.new(fixtures('kitchen', 'debian.stretch.yml')) }

    subject { profile }

    describe '#name' do
      it 'should return file name without extension' do
        expect(subject.name).to eq 'debian.stretch'
      end
    end

    describe '#to_s' do
      it 'should return file name without extension' do
        expect(subject.to_s).to eq 'debian.stretch'
      end
    end

    describe '#valid?' do
      it 'should return true' do
        expect(subject.valid?).to be true
      end
    end

    describe '#suites' do
      it 'should a list of KitchenToolkit::Suite objects' do
        expect(subject.suites).to be_a(Array)
        expect(subject.suites.first).to be_a(KitchenToolkit::Suite)
      end
    end

    describe '#config' do
      it 'should return the config loaded from YAML file' do
        expect(subject.config).to be_a(Hash)
      end
    end

  end


  describe 'invalid KitchenToolkit::Profile' do

    let(:profile) { described_class.new(fixtures('invalid_config.yml')) }

    subject { profile }

    describe '#name' do
      it 'should return file name without extension' do
        expect(subject.name).to eq 'invalid_config'
      end
    end

    describe '#to_s' do
      it 'should return file name without extension' do
        expect(subject.to_s).to eq 'invalid_config'
      end
    end

    describe '#valid?' do
      it 'should return true' do
        expect(subject.valid?).to be false
      end
    end

    describe '#suites' do
      it 'should an empty list' do
        expect(subject.suites).to eq([])
      end
    end

    describe '#config' do
      it 'should an empty hash' do
        expect(subject.config).to eq({})
      end
    end

  end

end
