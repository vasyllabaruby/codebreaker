module Codebreaker
  CODE_SIZE = 4
  def self.is_valid(code)
    return if code =~ /^[1-6]{#{CODE_SIZE}}$/
    raise RegexpError
  end
end
