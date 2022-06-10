# frozen_string_literal: true

RSpec.describe 'Game' do
  include Codebreaker
  context '#hint' do
    let(:game) { Codebreaker::Game.new }
    it 'you have not hints true' do
      game.new_game('tester', :easy)
      game.instance_variable_set(:@hints, 0)
      expect(game.hint).to eq('you have no hints')
    end
    it 'you have not hints false' do
      game.new_game('tester', :easy)
      expect(game.hint).not_to eq('you have no hints')
    end
    it 'hint is one of secret code numbers' do
      game.new_game('tester', :easy)
      expect(game.instance_variable_get(:@secret_code).chars).to include(game.hint)
    end
  end
end
