# frozen_string_literal: true

require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'game.rb'

class Interface
  MENU = ['0. Open cards', '1. Stand', '2. Hit'].freeze
  OPTIONS = %i[open_cards stand hit].freeze

  def initialize(input, output)
    @input = input
    @output = output
    @dealer = Dealer.new
  end

  def main
    enter unless @game

    output(game_state)
    @game.over? ? winner_notice : action
    main
  end

  private

  def input
    send(@input)
  end

  def output(*params)
    send(@output, *params)
  end

  def enter
    output('Enter your name')
    @player = Player.new(input.chomp)
    @game = Game.new(@player, @dealer)
    @game.start
  end

  def menu
    @player.hand.full? ? MENU[0...-1] : MENU
  end

  def options
    @player.hand.full? ? OPTIONS[0...-1] : OPTIONS
  end

  def action
    output(menu)
    @game.public_send options[input.to_i] || :do_nothing
  end

  def winner_notice
    output(@game.winner ? "#{@game.winner.name} wins!" : 'Tie!')
    play_again
  end

  def play_again
    output('Input y to play again or anything else to exit')
    abort if input.chomp !~ /\s*y\s*/i
    @game.start
  end

  def game_state
    [@dealer, @player, "Cash: #{@player.cash}, bank: #{@game.bank}"]
  end
end
