# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'terminal_interface.rb'

game = Game.new(interface: TerminalInterface.new)
game.main
