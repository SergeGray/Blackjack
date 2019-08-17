# frozen_string_literal: true

require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'money_account.rb'
require_relative 'game_helper.rb'
require_relative 'game.rb'
require_relative 'terminal_interface.rb'

game = Game.new(interface: TerminalInterface.new)
game.main
