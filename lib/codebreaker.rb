# frozen_string_literal: true
require_relative 'codebreaker/generator'

require_relative "codebreaker/version"

module Codebreaker
  class Main
    puts Generator.generate
  end
end
