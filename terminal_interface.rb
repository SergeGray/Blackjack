# frozen_string_literal: true

class TerminalInterface
  MENU = ['0. Open cards', '1. Stand', '2. Hit'].freeze

  def input
    gets
  end

  def output(*params)
    puts params
  end

  def name
    puts 'Enter your name'
    gets.chomp
  end

  def menu
    puts MENU
  end

  def open_menu
    puts MENU[0...-1]
  end

  def win_message(winner)
    puts "#{winner.name} wins!"
  end

  def tie_message
    puts 'Tie!'
  end

  def play_again
    puts 'Input y to play again or anything else to exit'
    gets.chomp.match?(/^\s*y\s*$/i)
  end
end
