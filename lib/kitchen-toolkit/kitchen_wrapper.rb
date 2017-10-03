require 'colorize'

require 'kitchen-toolkit/server'

module KitchenToolkit
  class KitchenWrapper
    class << self

      def prepare(suite, opts = {})
        title "Preparing virtual machine '#{@suite_name}'".bold
        Server.new(suite, opts).prepare
      end


      def create(suite, opts = {})
        title "Creating '#{suite}'".bold
        Server.new(suite, opts).create
      end


      def destroy(suite, opts = {})
        title "Destroying '#{suite}'".bold
        Server.new(suite, opts).destroy
      end


      def converge(suite, opts = {})
        title "Converging '#{suite}'".bold
        Server.new(suite, opts).converge
      end


      def test(suite, opts = {})
        title "Preparing tests for '#{suite}'".bold
        Server.new(suite, opts).test
      end


      def dump(suite, opts = {})
        title "Dumping pillars for '#{suite}'".bold
        Server.new(suite, opts).dump
      end


      def verify(suite, opts = {})
        title "Verifying '#{suite}'".bold
        Server.new(suite, opts).verify
      end


      def package(suite, opts = {})
        title "Packaging '#{suite}'".bold
        Server.new(suite, opts).package
      end


      def login(suite, opts = {})
        title "Logging into '#{suite}'".bold
        Server.new(suite, opts).login
      end


      def list(profile)
        system("KITCHEN_YAML='#{profile.file}' kitchen list")
      end


      def title(str)
        puts "\n-- #{str} --\n\n"
      end

    end
  end
end
