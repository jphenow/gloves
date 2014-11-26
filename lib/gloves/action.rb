require 'gloves/feedback'
module Gloves
  class Action
    include Feedback

    attr_accessor :name
    attr_accessor :title
    attr_accessor :subtitle

    def initialize(name)
      @name = name
    end

    def output
      {
        uid: name,
        title: name || title,
        subtitle: subtitle || title || name,
        arg: "do #{name}", # TODO
        valid: "yes"
      }
    end

    def called(&block)
      if block_given?
        @called_block = block
      else
        @called_block
      end
    end
  end
end
