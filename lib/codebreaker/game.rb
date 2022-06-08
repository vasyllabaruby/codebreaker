# frozen_string_literal: true

require_relative 'validate_service'
require_relative 'secret_code'
require_relative 'version'
require_relative 'player'

module Codebreaker
  # Main class for codebreaker game
  class Game
    attr_writer :secret_code
    attr_accessor :user_code, :player, :statistic
    attr_reader :result, :attempts, :hints, :old_hint

    def initialize
      @secret_code = generate_s_code
      @user_code = []
      @statistic = []
      @attempts = 0
      @hints = 0
      @old_hint = 0
    end

    def new_game(name, difficulty)
      @secret_code = generate_s_code
      @player = ::Codebreaker::Player.new(name)
      @player.difficulty = (difficulty)
      difficulty_level(difficulty)
    end

    def play(user_code, secret_code = @secret_code)
      return nil unless Codebreaker.valid?(user_code)

      @result = []
      @secret_code = secret_code
      check(user_code.chars, @secret_code.chars)
      @attempts -= 1
      save_stats(result)
      result.join
    end

    def difficulty_level(difficulty)
      case difficulty
      when :easy
        set_attempts_and_hints(15, 2)
      when :medium
        set_attempts_and_hints(10, 1)
      when :hell
        set_attempts_and_hints(5, 1)
      end
    end

    def set_attempts_and_hints(attempt, hint)
      @attempts = attempt
      @hints = hint
    end

    def hint
      if @hints.positive?
        result = @secret_code[rand(0..3)]
        hint if result == @old_hint
        @hints -= 1
        result
      else
        'you have no hints'
      end
    end

    private

    def save_stats(result)
      return unless result[0] == '++++ (win)' || @attempts.positive?

      @player.attempts_used = (@attempts)
      @player.hints_used = (@hints)
      @statistic << @player
    end

    def generate_s_code
      code = SecretCode.new
      code.generate
    end

    def check(user_code, secret_code)
      return @result = ['++++ (win)'] if user_code == secret_code

      check_in_same_position(user_code, secret_code)
      @result
    end

    def check_in_same_position(user_code, secret_code)
      index = -1
      while index < secret_code.size - 1
        index += 1
        next unless secret_code[index] == user_code[index]

        user_code[index] = 0
        secret_code[index] = -1
        @result << '+'
      end
      check_in_different_position(user_code, secret_code)
    end

    def check_in_different_position(user_code, secret_code)
      index = -1
      while index < user_code.size - 1
        index += 1
        next unless user_code.include? secret_code[index]

        user_code[user_code.index(secret_code[index])] = 0
        secret_code[index] = -1
        @result << '-'
      end
    end
  end
end
