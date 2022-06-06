class Generator
  attr_reader :code
  CODE_SIZE = 4

  def initialize
    @code = ""
  end

  def self.generate
    @code = ""
    CODE_SIZE.times {@code += rand(1..6).to_s }
    @code
  end
end