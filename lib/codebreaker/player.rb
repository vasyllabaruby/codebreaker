# frozen_string_literal: true

module Codebreaker
  # Player entity class
  class Player
    attr_accessor :rating, :attempts_total, :attempts_used, :hints_total, :hints_used
    attr_reader :name, :difficulty

    def initialize(name)
      @name = name
      @attempts_total = 0
      @hints_total = 0
      @difficulty = 0
    end

    def difficulty=(difficulty)
      @difficulty = difficulty
      case @difficulty
      when 1
        set_attempts_and_hints(15, 2)
      when 2
        set_attempts_and_hints(10, 1)
      when 3
        set_attempts_and_hints(5, 1)
      end
    end

    private

    def set_attempts_and_hints(attempt, hint)
      @attempts_total += attempt
      @hints_total += hint
    end
  end
end
