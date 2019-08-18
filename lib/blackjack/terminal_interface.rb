# frozen_string_literal: true

module Blackjack
  class TerminalInterface
    MENU = ['0. Open cards', '1. Stand', '2. Hit'].freeze

    def name
      puts 'Enter your name'
      gets.chomp
    end

    def state_message(player, dealer, bank)
      [dealer, player].map do |participant|
        puts "#{participant.name}'s hand: #{participant.view_hand}, "\
            "score: #{participant.view_score}"
      end
      puts "cash: #{player.wallet}, bank: #{bank}"
    end

    def menu
      puts MENU
    end

    def open_menu
      puts MENU[0...-1]
    end

    def choice
      gets.to_i
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

    def bankrupt
      puts 'Not enough money to play. The game will now exit'
    end
  end
end
