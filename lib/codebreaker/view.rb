require_relative 'player'
require_relative 'validate_service'
require_relative 'game'

module Codebreaker
  #Class to interact with the console
  class View

    attr_reader :game

    def welcome
      puts 'Welcome!!!'
      menu
    end

    def menu
      puts "Please input number: \n\t1 to start\n\t2 to rules\n\t3 to stats\n\t4 to exit"
      command = gets
      case command.to_i
      when 1 then game_registration
      when 2 then rules
      when 3 then stats
      when 4 then puts 'goodbye'
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
      new_player.difficulty(choose_difficulty)
      puts "\n\t\tGame started   !!!!"
      @game = Game.new
      @game.difficulty_level(new_player.get_diff)
      lets_play
    end

    private

    def lets_play
      step = gets.chomp.to_s
      case step
      when 'hint'
        puts @game.hint
        lets_play
      when 'exit'
        abort 'Goodbye'
      else
        result = @game.play(step)
        if result.nil?
          unexpected_command_message
          lets_play
        end
        puts result
        abort if result == '++++ (win)'
        lets_play if @game.attempt.positive?
      end
    end

    def unexpected_command_message
      puts "Invalid values Please input: hint, exit or code"
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
      puts "Please choose difficulty:\n\t1 - Easy\n\t2 - Medium\n\t3 - Hell"
      diff = gets.to_i
      diff_values = [1, 2, 3]
      return diff if diff_values.include?(diff)

      choose_difficulty
    end

  end
end

