# frozen_string_literal: true

# Method to print stats info in table format
module Codebreaker
  def show_stats
    if @statistics.empty?
      puts 'no stats data'
    else
      print_table
    end
  end

  def print_table
    format = '%-8s %-8s %-15s %-15s %-15s %-15s %s'
    puts format(format, 'Rating', 'Name', 'Difficulty', 'Attempts Total', 'Attempts Used', 'Hints Total',
                'Hints Used')
    i = 0
    @statistics.each do |player|
      puts format(format, i += 1, player.name, player.difficulty, player.attempts_total, player.attempts_used,
                  player.hints_total, player.hints_used)
    end
  end
end
