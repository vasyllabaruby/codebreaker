# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'Game' do
  include Codebreaker
  context '#difficulty_level' do
    let(:game) { Codebreaker::Game.new }
    it 'Codebreaker game test difficulty_level method' do
      diff_test(:easy, 15, 2)
      diff_test(:medium, 10, 1)
      diff_test(:hell, 5, 1)
    end

    def diff_test(diff, attempts, hints)
      game.difficulty_level(diff)
      expect(game.attempts).to eq(attempts)
      expect(game.hints).to eq(hints)
    end
  end
end
