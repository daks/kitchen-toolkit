require 'spec_helper'

describe KitchenToolkit::Server do

  let(:server) { described_class.new('base', minion_id: 'foo', profile: double('profile', file: 'foo')) }

  subject { server }

  describe '#prepare' do
    it 'should call kitchen command to prepare instance' do
      expect(subject).to receive(:destroy).and_return(true)
      expect(subject).to receive(:create).and_return(true)
      expect(subject).to receive(:converge).and_return(true)
      subject.prepare
    end
  end

  describe '#create' do
    it 'should call kitchen command to create instance' do
      expect(subject).to receive(:system).with("KITCHEN_YAML='foo' kitchen create base").and_return(true)
      subject.create
    end
  end

  describe '#destroy' do
    it 'should call kitchen command to destroy instance' do
      expect(subject).to receive(:system).with("KITCHEN_YAML='foo' kitchen destroy base").and_return(true)
      subject.destroy
    end
  end

  describe '#converge' do
    it 'should call kitchen command to converge instance' do
      expect(subject).to receive(:system).with("KITCHEN_YAML='foo' kitchen converge base").and_return(true)
      subject.converge
    end
  end

  describe '#package' do
    it 'should call kitchen command to package instance' do
      expect(subject).to receive(:system).with("KITCHEN_YAML='foo' kitchen package base").and_return(true)
      subject.package
    end
  end

  describe '#test' do
    it 'should call kitchen command to test instance' do
      expect(subject).to receive(:dump).and_return(true)
      expect(subject).to receive(:verify).and_return(true)
      subject.test
    end
  end

  describe '#dump' do
    it 'should call kitchen command to dump instance pillars' do
      expect(subject).to receive(:fetch_pillars).and_return({ 'local': {} })
      expect(subject).to receive(:write_file)
      subject.dump
    end
  end

  describe '#verify' do
    it 'should call kitchen command to verify instance' do
      expect(subject).to receive(:system).with("KITCHEN_YAML='foo' kitchen verify base").and_return(true)
      subject.verify
    end
  end

  describe '#fetch_pillars_command' do
    it 'should build kitchen command to dump instance pillars' do
      expect(subject.fetch_pillars_command).to eq "KITCHEN_YAML='foo' kitchen exec base -c 'sudo salt-call --local --id foo --config /tmp/kitchen/etc/salt --out json --log-level quiet pillar.items' | tail -n +2"
    end
  end

end
