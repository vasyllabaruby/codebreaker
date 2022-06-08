# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'Game' do
  include Codebreaker
  it 'Codebreaker need to be instant of Main' do
    game = Codebreaker::Game.new
    expect(game).to be_instance_of(Codebreaker::Game)
  end
  context '#play' do
    let(:game) { Codebreaker::Game.new }
    it 'Codebreaker game test play method' do
      play_test('6543', '5643', '++--')
      play_test('6543', '6411', '+-')
      play_test('6543', '6544', '+++')
      play_test('6543', '3456', '----')
      play_test('6543', '6666', '+')
      play_test('6543', '2666', '-')
      play_test('6543', '2222', '')
      play_test('6666', '1661', '++')
      play_test('1234', '3124', '+---')
      play_test('1234', '1524', '++-')
      play_test('1234', '1234', '++++ (win)')
    end
    def play_test(user_code, secret_code, result)
      expect(game.play(user_code, secret_code)).to eq(result)
    end
  end
end
