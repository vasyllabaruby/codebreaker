# frozen_string_literal: true

# validation method for codebreaker
module Codebreaker
  CODE_SIZE = 4
  def self.valid?(code)
    return if code =~ /^[1-6]{#{CODE_SIZE}}$/

    raise RegexpError
  end
end
