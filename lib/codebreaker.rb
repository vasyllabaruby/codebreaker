# frozen_string_literal: true
require_relative 'codebreaker/secret_code'
require_relative 'codebreaker/validate_service'
require_relative "codebreaker/version"

module Codebreaker
  class Main
    attr_writer :secret_code
    attr_writer :secret_shelter
    attr_accessor :user_code
    attr_reader :result

    def initialize
      @secret_code = []
      @user_code = []
      @result = []
    end

    def play(user_code, secret_code)
      Codebreaker.is_valid(user_code)
      @user_code = user_code.chars
      @secret_code = secret_code.chars
      @result = []
      check
      result
    end

    private

    def check
      return @result = "++++ (win)" if @user_code == @secret_code
      check_in_same_position
      check_in_different_position
      result
    end

    private

    def check_in_same_position
      @secret_code.each_with_index do |el, index |
        if el == @user_code[index]
          @user_code[index] = 0
          @secret_code[index] = -1
          @result << "+"
        end
      end
    end

    private

    def check_in_different_position
      @secret_code.each do |el|
        if @user_code.include? el
          @result << "-"
        end
      end
    end

  end
end
