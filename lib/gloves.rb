require "gloves/version"
require "gloves/workflow"
require "gloves/bootstrap"

module Gloves
  def self.boot(klass, location)
    @booter = Bootstrap.new(klass, location)
    @booter.boot
    @booter
  end

  def self.environment
    var = ENV['GLOVES_ENV'].to_s
    var.length > 1 ? var : "live"
  end

  def self.root
    @booter.root
  end

  def self.app_class
    @booter.app_class
  end
end
