# frozen_string_literal: true

require_relative 'validate_service'
require_relative 'secret_code'
require_relative 'version'

module Codebreaker
  # Main class for codebreaker game
  class Main
    attr_writer :secret_code
    attr_accessor :user_code
    attr_reader :result, :attempt, :hints

    def initialize
      @secret_code = generate_s_code
      @user_code = []
      @result = []
      @attempt = 0
      @hints = 0
    end

    def play(user_code, secret_code = @secret_code)
      Codebreaker.valid?(user_code)
      @user_code = user_code.chars
      @secret_code = secret_code.chars
      check
      result.join
    end

    def difficulty(level)
      case level
      when 'easy' then @attempt = 15, @hints = 2
      when 'medium' then @attempt = 10, @hints = 1
      when 'hell' then @attempt = 5, @hints = 1
      end
    end

    def hint
      if @hints.positive?
        @secret_code[rand(0..3)]
      else
        'you have no hints'
      end
    end

    private

    def generate_s_code
      code = SecretCode.new
      code.generate
    end

    def check
      return @result = ['++++ (win)'] if @user_code == @secret_code

      check_in_same_position
      check_in_different_position
      result
    end

    def check_in_same_position
      index = -1
      while index < @secret_code.size - 1
        index += 1
        next unless @secret_code[index] == @user_code[index]

        @user_code[index] = 0
        @secret_code[index] = -1
        @result << '+'
      end
    end

    def check_in_different_position
      index = -1
      while index < @user_code.size - 1
        index += 1
        next unless @user_code.include? @secret_code[index]

        @user_code[@user_code.index(@secret_code[index])] = 0
        @secret_code[index] = -1
        @result << '-'
      end
    end
  end
end
