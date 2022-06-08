# frozen_string_literal: true

module Codebreaker
  # Player entity class
  class Player
    attr_accessor :attempts_total, :hints_total
    attr_reader :name, :difficulty, :attempts_used, :hints_used

    def initialize(name)
      @name = name
      @attempts_total = 0
      @hints_total = 0
      @difficulty = 0
    end

    def difficulty=(difficulty)
      @difficulty = difficulty
      case @difficulty
      when :easy
        set_attempts_and_hints(15, 2)
      when :medium
        set_attempts_and_hints(10, 1)
      when :hell
        set_attempts_and_hints(5, 1)
      end
    end

    def attempts_used=(game_attempt)
      @attempts_used = @attempts_total - game_attempt
    end

    def hints_used=(game_hints)
      @hints_used = @hints_total - game_hints
    end

    def to_s
      " #{name} | #{difficulty} | #{attempts_total} | #{attempts_used} | #{hints_total} | #{hints_used}"
    end

    private

    def set_attempts_and_hints(attempt, hint)
      @attempts_total += attempt
      @hints_total += hint
    end
  end
end
