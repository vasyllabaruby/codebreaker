# frozen_string_literal: true

module Codebreaker
  # Player entity class
  class Player
    attr_accessor :attempts_total, :hints_total, :difficulty
    attr_reader :name, :attempts_used, :hints_used

    def initialize(name)
      @name = name
      @attempts_total = 0
      @hints_total = 0
    end

    def update_attempts_used(game_attempt)
      @attempts_used = @attempts_total - game_attempt
    end

    def update_hints_used(game_hints)
      @hints_used = @hints_total - game_hints
    end
  end
end
