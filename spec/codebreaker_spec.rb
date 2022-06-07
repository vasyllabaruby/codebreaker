# frozen_string_literal: true
require 'codebreaker/game'

RSpec.describe 'Game' do
  include Codebreaker
  it 'has a version number' do
    expect(Codebreaker::VERSION).not_to be nil
  end

  it 'Codebreaker need to be instant of Main' do
    game = Codebreaker::Game.new
    expect(game).to be_instance_of(Codebreaker::Game)
  end

  context '#play' do
    let(:game) { Codebreaker::Game.new }
    it 'Codebreaker game test 1' do
      result = game.play('6543', '5643')
      expect(result).to eq('++--')
    end
    it 'Codebreaker game test 2' do
      result = game.play('6543', '6411')
      expect(result).to eq('+-')
    end
    it 'Codebreaker game test 3' do
      result = game.play('6543', '6544')
      expect(result).to eq('+++')
    end
    it 'Codebreaker game test 4' do
      result = game.play('6543', '3456')
      expect(result).to eq('----')
    end
    it 'Codebreaker game test 5' do
      result = game.play('6543', '6666')
      expect(result).to eq('+')
    end
    it 'Codebreaker game test 6' do
      result = game.play('6543', '2666')
      expect(result).to eq('-')
    end
    it 'Codebreaker game test 7' do
      result = game.play('6543', '2222')
      expect(result).to eq('')
    end
    it 'Codebreaker game test 8' do
      result = game.play('6666', '1661')
      expect(result).to eq('++')
    end
    it 'Codebreaker game test 9' do
      result = game.play('1234', '3124')
      expect(result).to eq('+---')
    end
    it 'Codebreaker game test 10' do
      result = game.play('1234', '1524')
      expect(result).to eq('++-')
    end
    it 'Codebreaker game test 11' do
      result = game.play('1234', '1234')
      expect(result).to eq('++++ (win)')
    end
  end
  context '.valid?' do
    it 'Validate service test' do
      expect(Codebreaker.valid?(1237)).to eq(false)
    end
  end
end
