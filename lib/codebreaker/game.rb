# frozen_string_literal: true

require_relative 'validate_service'
require_relative 'secret_code'
require_relative 'version'

module Codebreaker
  # Main class for codebreaker game
  class Game
    attr_writer :secret_code
    attr_accessor :user_code
    attr_reader :result, :attempt, :hints, :hint

    def initialize
      @secret_code = generate_s_code
      @user_code = []
      @attempt = 0
      @hints = 0
      @hint = 0
    end

    def play(user_code, secret_code = @secret_code)
      return nil unless Codebreaker.valid?(user_code)

      @result = []
      @secret_code = secret_code
      check(user_code.chars, @secret_code.chars)
      @attempt -= 1
      result.join
    end

    def difficulty_level(difficulty)
      case difficulty
      when 1
        @attempt = 15
        @hints = 2
      when 2
        @attempt = 10
        @hints = 1
      when 3
        @attempt = 5
        @hints = 1
      end
    end

    def hint
      if @hints.positive?
        result = @secret_code[rand(0..3)]
        hint if result == @hint
        @hints -= 1
        result
      else
        'you have no hints'
      end
    end

    private

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