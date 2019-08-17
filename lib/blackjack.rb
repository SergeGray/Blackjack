# frozen_string_literal: true

require_relative 'blackjack/card.rb'
require_relative 'blackjack/deck.rb'
require_relative 'blackjack/hand.rb'
require_relative 'blackjack/player.rb'
require_relative 'blackjack/dealer.rb'
require_relative 'blackjack/money_account.rb'
require_relative 'blackjack/game_helper.rb'
require_relative 'blackjack/game.rb'
require_relative 'blackjack/terminal_interface.rb'

game = Game.new(interface: TerminalInterface.new)
game.main
