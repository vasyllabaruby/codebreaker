# frozen_string_literal: true

require_relative 'codebreaker/view'
class Test
  include Codebreaker
  # game = Codebreaker::Main.new
  # game.play('1113')
  # puts aa
  consol = View.new
  consol.welcome
end
