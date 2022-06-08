# frozen_string_literal: true

# validation method for codebreaker
module ValidateService
  def self.valid?(code)
    return true if code =~ /^[1-6]{#{::SecretCodeGenerator.const_get(:CODE_SIZE)}}$/

    false
  end

  def self.name_valid?(name)
    return true if name =~ /^\w{3,20}$/

    false
  end
end
