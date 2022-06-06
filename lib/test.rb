require_relative 'codebreaker'

class Test
  include(Codebreaker)
  game = Main.new
  secret_code = SecretCode.new
  secret_code.generate
  result = game.play("1234", secret_code.get_code)
  puts result
end
