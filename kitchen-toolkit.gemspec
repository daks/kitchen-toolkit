# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'kitchen-toolkit/version'

Gem::Specification.new do |s|
  s.name        = 'kitchen-toolkit'
  s.version     = KitchenToolkit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nicolas Rodriguez']
  s.email       = ['nicoladmin@free.fr']
  s.homepage    = 'https://github.com/n-rodriguez/kitchen-toolkit'
  s.summary     = %q{A Ruby gem to ease working with Kitchen}
  s.description = %q{This gem is designed to provide helpers to work with Salt/Kitchen/Vagrant}
  s.license     = 'MIT'

  # Kitchen framework
  s.add_dependency 'test-kitchen'

  # Kitchen driver (works with VirtualBox and libvirt)
  s.add_dependency 'kitchen-vagrant'

  # Kitchen provisioner
  s.add_dependency 'kitchen-salt'

  # Test framework
  s.add_dependency 'kitchen-inspec'

  # Unicode Normalization Form
  s.add_dependency 'unf'

  # Helper methods like "foo-bar".underscore
  s.add_dependency 'activesupport'

  # The ci-tool script is in Ruby.
  # Thor helps us to create CLI easily
  s.add_dependency 'thor'

  # Colorize output in CLI
  s.add_dependency 'colorize'

  # To deploy the code in production/staging
  s.add_dependency 'capistrano'
  s.add_dependency 'capistrano-scm-gitcopy'

  # Test with RSpec
  s.add_development_dependency 'rspec'

  # Code Coverage
  s.add_development_dependency 'simplecov'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
