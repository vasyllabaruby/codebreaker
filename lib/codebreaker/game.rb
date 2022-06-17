# frozen_string_literal: true

require_relative 'validate_service'
require_relative 'secret_code'
require_relative 'version'
require_relative 'player'
require_relative 'data_saver'

module Codebreaker
  # Main class for codebreaker game
  class Game
    include(DataSaver)
    attr_writer :secret_code
    attr_accessor :user_code, :player, :statistic
    attr_reader :result, :attempts, :hints, :difficulty_values, :hints_list

    DIFFICULTY_VALUES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize
      @user_code = []
      load_stats
    end

    def new_game(name, difficulty)
      generate_secret_code
      @player = Player.new(name)
      difficulty_level(difficulty)
    end

    def play(user_code)
      return @secret_code if end_game?
      return nil unless ValidateService.code_valid?(user_code)

      @result = ''
      check(user_code.chars, @secret_code.chars)
      @attempts -= 1
      result
    end

    def hint
      @hints_list.pop
    end

    private

    def difficulty_level(difficulty)
      attempts_and_hints(DIFFICULTY_VALUES[difficulty])
      @player.current_difficulty(difficulty)
    end

    def attempts_and_hints(difficulty)
      @player.attempts_total = @attempts = difficulty[:attempts]
      @player.hints_total = @hints = difficulty[:hints]
      @hints_list = @secret_code.chars.sample(@hints)
    end

    def end_game?
      return true if result == '++++ (win)'
      return true unless @attempts.positive?

      false
    end

    def load_stats
      @statistic = load
      @statistic = [] if @statistic.nil? || @statistic == false
    end

    def save_stats
      @player.update_attempts_used(@attempts)
      @player.update_hints_used(@hints)
      @statistic.append(@player)
      save(@statistic)
    end

    def generate_secret_code
      @secret_code = SecretCodeGenerator.generate
    end

    def check(user_code, secret_code)
      return @result = '++++ (win)' if user_code == secret_code

      check_in_same_position(user_code, secret_code)
      check_in_different_position(user_code, secret_code)
    end

    def check_in_same_position(user_code, secret_code)
      user_code.length.times do |index|
        next unless secret_code[index] == user_code[index]

        user_code[index] = nil
        secret_code[index] = nil
        @result += '+'
      end
      user_code.compact!
      secret_code.compact!
    end

    def check_in_different_position(user_code, secret_code)
      user_code.length.times do |index|
        next unless user_code.include? secret_code[index]

        user_code[user_code.index(secret_code[index])] = nil
        @result += '-'
      end
    end
  end
end
