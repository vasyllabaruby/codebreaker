# frozen_string_literal: true

require 'rspec'
require 'json'
require 'codebreaker/game'

RSpec.describe 'Player' do

  let(:mario) do
    player = Codebreaker::Player.new('Mario')
    player.difficulty = :easy
    player.attempts_total = 15
    player.hints_total = 2
    player.update_attempts_used(14)
    player.update_hints_used(2)
    player.time = DateTime.new(2022, 7, 11, 20, 26, 27).strftime('%Y.%m.%d - %T')
    player
  end

  it 'Player set time' do
    player = Codebreaker::Player.new('Tester')
    player.time = DateTime.now
    expect(time).to eq(player.time)
  end

  it 'Player rows work as expected' do
    expect(mario.rows).to eq(['Mario', :easy, 15, 1, 2, 0, '2022.07.11 - 20:26:27'])
  end

  it 'game save player as expected' do
    game = Codebreaker::Game.new
    game.new_game('Mario', :easy)
    game.instance_variable_set(:@statistic, [])
    game.instance_variable_set(:@secret_code, '1111')
    game.play('1111')
    game.player.instance_variable_set(:@time, '2022.07.11 - 20:26:27')
    expect(game.statistic[0].rows).to eq(mario.rows)
  end
end
