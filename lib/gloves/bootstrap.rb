module Gloves
  class Bootstrap
    attr_reader :app_class, :root

    def initialize(app_class, location)
      @app_class = app_class
      @root = location
    end

    def boot
      require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
      require root.join('.bundle/bundler/setup') unless Gloves.environment == 'test'
      require 'alfred'
    end
  end
end
