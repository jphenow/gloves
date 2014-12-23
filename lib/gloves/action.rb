require 'gloves/feedback'
module Gloves
  class Action
    include Feedback

    attr_accessor :name
    attr_accessor :title
    attr_accessor :subtitle

    def initialize(name)
      @name = name.to_s
      @called_block = nil
    end

    def output
      {
        uid: name,
        title: title || name,
        subtitle: subtitle || title || name,
        arg: "do #{name}", # Passed to next script, may be unnecessary for how we solve
        valid: "yes" # Autocomplete off by default w/ "yes"
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
