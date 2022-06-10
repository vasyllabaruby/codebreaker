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
    attr_reader :result, :attempts, :hints, :old_hint, :difficulty_values

    DIFFICULTY_VALUES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze
    def initialize
      @secret_code = generate_secret_code
      @user_code = []
      @statistic = []
      @attempts = 0
      @hints = 0
      @old_hint = 0
      @difficulty_values = {}
    end

    def new_game(name, difficulty)
      @secret_code = generate_secret_code
      @player = ::Codebreaker::Player.new(name)
      difficulty_level(difficulty)
    end

    def play(user_code, secret_code = @secret_code)
      return nil unless ValidateService.code_valid?(user_code)

      @result = []
      @secret_code = secret_code
      check(user_code.chars, @secret_code.chars)
      @attempts -= 1
      save_stats if end_game?
      result.join
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

    def difficulty_level(difficulty)
      attempts_and_hints(DIFFICULTY_VALUES[difficulty])
      @player.current_difficulty(difficulty)
      @player.attempts_total = @attempts
      @player.hints_total = @hints
    end

    def attempts_and_hints(var)
      @attempts = var[:attempts]
      @hints = var[:hints]
    end

    def end_game?
      return true if result[0] == '++++ (win)'
      return true unless @attempts.positive?

      false
    end

    def save_stats
      @player.attempts_used = (@attempts)
      @player.hints_used = (@hints)
      @statistic << @player
    end

    def generate_secret_code
      SecretCodeGenerator.generate
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
