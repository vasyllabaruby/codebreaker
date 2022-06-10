# frozen_string_literal: true

module Codebreaker
  # Secret code entity for codebreaker to generate secret code
  module SecretCodeGenerator
    CODE_SIZE = 4

    def self.generate
      CODE_SIZE.times.map { rand(1..6).to_s }.join
    end
  end
end
