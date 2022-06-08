# frozen_string_literal: true

module SecretCodeGenerator
  # Secret code entity for codebreaker to generate secret code
  class SecretCode
    CODE_SIZE = 4
    attr_reader :s_code

    def initialize
      @s_code = ''
    end

    def generate
      CODE_SIZE.times { @s_code += rand(1..6).to_s }
      @s_code
    end
  end
end
