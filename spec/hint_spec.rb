# frozen_string_literal: true

RSpec.describe 'Game' do
  include Codebreaker
  context '#hint' do
    let(:game) { Codebreaker::Game.new }
    it 'return nil if you have no hints' do
      game.new_game('tester', :hell)
      game.hint
      expect(game.hint).to eq(nil)
    end
    it 'hint is not nil' do
      game.new_game('tester', :easy)
      expect(game.hint).not_to eq(nil)
    end
    it 'hint is one of secret code numbers' do
      game.new_game('tester', :easy)
      expect(game.instance_variable_get(:@secret_code).chars).to include(game.hint)
    end
  end
end
