# frozen_string_literal: true

module Codebreaker
  # Player entity class
  class Player
    attr_accessor :attempts_total, :hints_total
    attr_reader :name, :difficulty, :attempts_used, :hints_used

    DIFFICULTY_VALUES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    def initialize(name)
      @name = name
      @attempts_total = 0
      @hints_total = 0
      @difficulty = {}
    end

    def difficulty=(difficulty)
      @difficulty = difficulty
      attempts_and_hints(DIFFICULTY_VALUES[difficulty])
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

    def attempts_and_hints(var)
      @attempts_total += var[:attempts]
      @hints_total += var[:hints]
    end
  end
end
