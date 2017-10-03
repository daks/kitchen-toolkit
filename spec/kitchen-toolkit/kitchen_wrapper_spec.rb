require 'spec_helper'

describe KitchenToolkit::KitchenWrapper do

  describe '.login' do
    it 'should create a new instance of server and call login on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:login)
      described_class.login('foo', { foo: 'bar' })
    end
  end

  describe '.prepare' do
    it 'should create a new instance of server and call prepare on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:prepare)
      described_class.prepare('foo', { foo: 'bar' })
    end
  end

  describe '.create' do
    it 'should create a new instance of server and call create on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:create)
      described_class.create('foo', { foo: 'bar' })
    end
  end

  describe '.destroy' do
    it 'should create a new instance of server and call destroy on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:destroy)
      described_class.destroy('foo', { foo: 'bar' })
    end
  end

  describe '.converge' do
    it 'should create a new instance of server and call converge on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:converge)
      described_class.converge('foo', { foo: 'bar' })
    end
  end

  describe '.test' do
    it 'should create a new instance of server and call test on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:test)
      described_class.test('foo', { foo: 'bar' })
    end
  end

  describe '.dump' do
    it 'should create a new instance of server and call dump on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:dump)
      described_class.dump('foo', { foo: 'bar' })
    end
  end

  describe '.verify' do
    it 'should create a new instance of server and call verify on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:verify)
      described_class.verify('foo', { foo: 'bar' })
    end
  end

  describe '.package' do
    it 'should create a new instance of server and call package on it' do
      server = double('server')
      expect(described_class).to receive(:title)
      expect(KitchenToolkit::Server).to receive(:new).with('foo', { foo: 'bar' }).and_return(server)
      expect(server).to receive(:package)
      described_class.package('foo', { foo: 'bar' })
    end
  end

  describe '.list' do
    it 'should call kitchen command to get instances list' do
      profile = double('profile', file: 'foo')
      expect(described_class).to receive(:system).with("KITCHEN_YAML='foo' kitchen list")
      described_class.list(profile)
    end
  end

  describe '.title' do
    it 'should render text on console' do
      expect(described_class).to receive(:puts).with("\n-- foo --\n\n")
      described_class.title('foo')
    end
  end

end
