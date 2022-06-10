# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'Game' do
  include Codebreaker
  context '#difficulty_level' do
    let(:game) { Codebreaker::Game.new }

    all_cases = [[:easy, 15, 2],
                 [:medium, 10, 1],
                 [:hell, 5, 1]]

    all_cases.each do |difficulty, attempts, hints|
      it "when difficulty is #{difficulty} you have #{attempts} attempts and #{hints} hints" do
        game.new_game('Tester', difficulty)
        expect(game.attempts).to eq(attempts)
        expect(game.hints).to eq(hints)
      end
    end
  end
end
