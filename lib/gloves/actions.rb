module Gloves
  class Actions
    attr_reader :feedback
    attr_reader :items
    attr_reader :actions

    def initialize(feedback)
      @feedback = feedback
      @actions = []
    end

    def run_from_input(input)
      action = actions.detect { |action| action.name.to_s == input.to_s }
      if action && action.called
        action.called.call
      end
    end

    def build_items(input)
      actions.each { |action| feedback.add_item action.output }
    end

    def <<(action)
      @actions << action
    end
  end
end
