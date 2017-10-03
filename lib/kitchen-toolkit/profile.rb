require 'erb'
require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'

require 'kitchen-toolkit/suite'

module KitchenToolkit
  class Profile

    attr_reader :file, :name, :config

    def initialize(file)
      @file   = file
      @name   = File.basename(file, File.extname(file))
      @valid  = false
      @config = {}
      load_file
    end

    def to_s
      name
    end

    def valid?
      @valid
    end

    def suites
      (@config[:suites] || []).map { |s| Suite.new(s) }
    end

    private

      def load_file
        begin
          config  = YAML.load(ERB.new(IO.read(file)).result)
          @config = config.with_indifferent_access
          @valid  = true
        rescue => _
          @valid = false
        end
      end

  end
end
