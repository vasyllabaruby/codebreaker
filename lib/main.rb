# frozen_string_literal: true

require_relative 'codebreaker/secret_code'
require_relative 'codebreaker/validate_service'
require_relative 'codebreaker/version'

module Codebreaker
  # Main class for codebreaker game
  class Main
    attr_writer :secret_code
    attr_accessor :user_code
    attr_reader :result

    def initialize
      @secret_code = []
      @user_code = []
      @result = []
    end

    def play(user_code, secret_code)
      Codebreaker.valid?(user_code)
      @user_code = user_code.chars
      @secret_code = secret_code.chars
      @result = []
      check
      result.join
    end

    private

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
