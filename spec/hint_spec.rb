# frozen_string_literal: true

RSpec.describe 'Game' do
  include Codebreaker
  context '#hint' do
    let(:game) { Codebreaker::Game.new }
    it 'Codebreaker game test hint method' do
      expect(game.hint).to eq('you have no hints')
      game.new_game('tester', :easy)
      expect(game.hint).not_to eq('you have no hints')
    end
  end
end
