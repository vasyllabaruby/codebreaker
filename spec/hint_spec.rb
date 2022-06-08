# frozen_string_literal: true

RSpec.describe 'Game' do
  include Codebreaker
  context '#hint' do
    let(:game) { Codebreaker::Game.new }
    it 'Codebreaker game test hint method' do
      hint_test_to('you have no hints')
      game.difficulty_level(:easy)
      hint_test_not('you have no hints')
    end

    def hint_test_to(result)
      expect(game.hint).to eq(result)
    end

    def hint_test_not(result)
      expect(game.hint).not_to eq(result)
    end
  end
end
