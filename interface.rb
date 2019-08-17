# frozen_string_literal: true

class Interface
  MENU = ['0. Open cards', '1. Stand', '2. Hit'].freeze
  OPTIONS = %i[open_cards stand hit].freeze

  def input
    gets
  end

  def output(*params)
    puts *params
  end

  def name
    puts "Enter your name"
    gets.chomp
  end

  def menu
    puts MENU
    OPTIONS[gets.to_i]
  end

  def open_menu
    puts MENU[0...-1]
    OPTIONS[0...-1][gets.to_i]
  end

  def play_again
    puts 'Input y to play again or anything else to exit'
    gets.chomp.match?(/^\s*y\s*$/i)
  end
end
