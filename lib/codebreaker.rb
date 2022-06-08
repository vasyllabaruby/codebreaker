# frozen_string_literal: true

require_relative 'codebreaker/player'
require_relative 'codebreaker/validate_service'
require_relative 'codebreaker/game'

module Codebreaker
  # Class to interact with the console
  class Codebreaker
    attr_reader :game, :new_player, :statistics

    # name string between 3 -20
    # difficulty: easy, medium, hell
    def start_game(name, difficulty)
      @new_player = ::Codebreaker::Player.new(name)
      @new_player.difficulty = (difficulty)
      @game = Game.new
      @game.difficulty_level(difficulty)
    end
  end
end
