module KitchenToolkit

  def self.profiles_dir
    File.expand_path('config/kitchen', Dir.pwd)
  end

  def self.profile_files
    Dir[File.join(profiles_dir, '**', '*.yml')].map(&:to_s).sort
  end

  def self.kitchen_profiles
    profile_files.map { |f| Profile.new(f) }.select(&:valid?)
  end

  require 'kitchen-toolkit/version'
  require 'kitchen-toolkit/profile'
  require 'kitchen-toolkit/cli'
end
