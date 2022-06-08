# frozen_string_literal: true

require_relative 'player'
require_relative 'validate_service'
require_relative 'game'

module Codebreaker
  # Class to interact with the console
  class View
    attr_reader :game, :statistics, :new_player

    def initialize
      @statistics = []
    end

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

    def game_registration
      @new_player = ::Codebreaker::Player.new(input_name)
      @new_player.difficulty = (choose_difficulty)
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
      if @game.attempts.positive?
        lets_play
      else
        you_loose
      end
    end

    def result(step)
      result = @game.play(step)
      unexpected_command_message if result.nil?
      you_win if result == '++++ (win)'
      puts result
    end

    def you_win
      puts '++++ (win)'
      save_stats
      puts "\t\t Congratulation!!!\none mote time?\n"
      menu
    end

    def you_loose
      puts 'you loose'
      save_stats
      puts "\tone mote time?\n"
      menu
    end

    def save_stats
      @new_player.attempts_used = @game.attempts
      @new_player.hints_used = @game.hints
      @statistics << @new_player
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
      name = gets.chomp
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
      diff_values = %i[easy medium hell]
      return diff if diff_values.include?(diff)

      choose_difficulty
    end

    def stats
      print_table
      menu
    end

    def print_table
      format = '%-8s %-8s %-15s %-15s %-15s %-15s %s'
      puts format % ['Rating', 'Name', 'Difficulty', 'Attempts Total', 'Attempts Used', 'Hints Total', 'Hints Used']
      @statistics.each_with_index do |player, i|
        puts format % [ i+1, player.name, player.difficulty, player.attempts_total, player.attempts_used,
                        player.hints_total, player.hints_used ]
      end
    end
  end
end
