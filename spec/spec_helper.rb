require 'simplecov'
require 'rspec'

# Start Simplecov
SimpleCov.start do
  add_filter 'spec/'
end

require 'kitchen-toolkit'

FIXTURE_PATH = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), 'fixtures')))

def fixtures(*args)
  FIXTURE_PATH.join(*args)
end
