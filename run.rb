# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'interface.rb'

game = Game.new(interface: Interface.new)
game.main
