# frozen_string_literal: true

require "awesome_print"
AwesomePrint.pry!

Pry.config.prompt = PryRails::RAILS_PROMPT if defined?(PryRails::RAILS_PROMPT)
