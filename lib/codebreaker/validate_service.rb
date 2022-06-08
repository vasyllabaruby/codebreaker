# frozen_string_literal: true

# validation method for codebreaker
module ValidateService
  CODE_SIZE = 4
  def self.valid?(code)
    return true if code =~ /^[1-6]{#{CODE_SIZE}}$/

    false
  end

  def self.name_valid?(name)
    return true if name =~ /^\w{3,20}$/

    false
  end
end
