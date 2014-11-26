# TODO Find out what we can do about loading from your script being run
require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require './bundle/bundler/setup'
require 'alfred'

require 'gloves/actions'
require 'gloves/action'

module Gloves
  class Workflow
    attr_reader :alfred
    attr_reader :actions

    def initialize(without_run = false)
      do_run = !without_run && actionable?

      Alfred.with_friendly_error do |alfred|
        @actions = Actions.new alfred.feedback
        @alfred = alfred

        yield self, alfred
      end

      if do_run
        run!
      else
        actions.build_items raw_args
        print actions.feedback.to_xml(raw_args)
      end
    end

    def action(name, &block)
      new_action = Action.new(name)
      yield new_action
      actions << new_action
      new_action
    end

    def action_arguments
      arg_words[1..-1]
    end

    def store
      @store ||= Storage.new alfred
    end

    def run!
      actions.run_from_input current_action
    end
    private :run!

    def current_action
      arg_words[0]
    end
    private :current_action

    def actionable?
      !xml_input?
    end
    private :actionable?

    def arg_words
      if xml_input?
        xml_args.to_s.strip.split(" ")
      else
        raw_args.to_s.strip.split(" ")
      end
    end
    private :arg_words

    def xml_args
      raw_args[/<arg>(.*?)<\/arg>/, 1].to_s
    end
    private :xml_args

    def raw_args
      ARGV[0].to_s
    end
    private :raw_args

    def xml_input?
      !!raw_args.match(/<item.*>.+<\/item>/)
    end
    private :xml_input?
  end
end
