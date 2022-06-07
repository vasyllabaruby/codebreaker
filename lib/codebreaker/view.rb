# frozen_string_literal: true

require_relative 'player'
require_relative 'validate_service'
require_relative 'game'

module Codebreaker
  # Class to interact with the console
  class View
    attr_reader :game

    def welcome
      puts 'Welcome!!!'
      menu
    end

    def menu
      puts "Please input command: \n\tstart\n\trules\n\tstats\n\texit"
      command = gets.chomp
      case command
      when 'start' then game_registration
      when 'rules' then rules
      when 'stats' then stats
      when 'exit' then exit
      else puts 'You have passed unexpected command. Please choose one from listed commands', menu
      end
    end

    def rules
      file = File.open('Rules.txt')
      file_data = file.read
      puts file_data
      file.close
      menu
    end

    def stats
      puts 'are we need db?'
      menu
    end

    def game_registration
      new_player = ::Codebreaker::Player.new(input_name)
      new_player.difficulty = (choose_difficulty)
      puts "\n\t\tGame started   !!!!"
      @game = Game.new
      @game.difficulty_level(new_player.difficulty)
      lets_play
    end

    private

    def lets_play
      step = gets.chomp.to_s
      hint if step == 'hint'
      exit if step == 'exit'
      result(step)
      lets_play if @game.attempts.positive?
    end

    def result(step)
      result = @game.play(step)
      unexpected_command_message if result.nil?
      puts result
      abort if result == '++++ (win)'
    end

    def hint
      puts @game.hint
      lets_play
    end

    def exit
      abort 'Goodbye'
    end

    def unexpected_command_message
      puts 'Invalid values Please input: hint, exit or code'
      lets_play
    end

    def input_name
      puts 'Please input your name'
      name = gets
      return if name.equal?('exit')

      not_valid_name unless Codebreaker.name_valid?(name)
      name
    end

    def not_valid_name
      puts 'your name not valid, must be mor then 3 characters and less then 20'
      input_name
    end

    def choose_difficulty
      puts "Please choose difficulty:\n\tEasy\n\tMedium\n\tHell"
      diff = gets.chomp.downcase.to_sym
      diff_values = { easy: 1, medium: 2, hell: 3 }
      return diff_values[diff] if diff_values.keys.include?(diff)

      choose_difficulty
    end
  end
end
