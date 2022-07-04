# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'Game' do
  include Codebreaker
  it 'Codebreaker need to be instant of Main' do
    game = Codebreaker::Game.new
    expect(game).to be_instance_of(Codebreaker::Game)
  end

  context '#play' do
    all_cases = [['6543', '5643', '++--'], ['6543', '6411', '+-'], ['6543', '6544', '+++'],
                 ['6543', '3456', '----'], ['6543', '6666', '+'], ['6543', '2666', '-'],
                 ['6543', '2222', ''], ['6666', '1661', '++'], ['1234', '3124', '+---'],
                 ['1234', '1524', '++-'], ['1234', '1234', '++++']]

    all_cases.each do |user_code, secret_code, result|
      it "when user code is #{user_code} and secret is #{secret_code} result is #{result}" do
        game = Codebreaker::Game.new
        game.new_game('Mykola', :medium)
        game.instance_variable_set(:@secret_code, secret_code)
        expect(game.play(user_code)).to eq(result)
      end
    end
  end
end
