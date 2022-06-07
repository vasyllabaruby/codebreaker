module Codebreaker
  #User entity
  class Player
    attr_accessor :rating, :attempts_total, :attempts_used, :hints_total, :hints_used, :difficulty
    attr_reader :name

    def initialize(name)
      @name = name
      @attempts_total = 0
      @hints_total = 0
    end

    def get_diff
      @difficulty
    end

    def difficulty(difficulty)
      @difficulty = difficulty
      case @difficulty
      when 1
        @attempts_total += 15
        @hints_total += 2
      when 2
        @attempts_total += 10
        @hints_total += 1
      when 3
        @attempts_total += 5
        @hints_total += 1
      end
    end
  end
end
