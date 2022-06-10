# frozen_string_literal: true

module Codebreaker
  # validation method for codebreaker
  module ValidateService
    def self.valid?(code)
      return true if code =~ /^[1-6]{#{::Codebreaker::SecretCodeGenerator.const_get(:CODE_SIZE)}}$/

      false
    end

    def self.name_valid?(name)
      return true if name =~ /^\w{3,20}$/

      false
    end
  end
end
