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

    all_cases = [['6543', '5643', '++--'],
                 ['6543', '6411', '+-'],
                 ['6543', '6544', '+++'],
                 ['6543', '3456', '----'],
                 ['6543', '6666', '+'],
                 ['6543', '2666', '-'],
                 ['6543', '2222', ''],
                 ['6666', '1661', '++'],
                 ['1234', '3124', '+---'],
                 ['1234', '1524', '++-'],
                 ['1234', '1234', '++++ (win)']]

    all_cases.each do |el|
      it "when user code is #{el[0]} and secret is #{el[1]} result is #{el[2]}" do
        game.new_game('Mykola', :medium)
        expect(game.play(el[0], el[1])).to eq(el[2])
      end
    end
  end
end
