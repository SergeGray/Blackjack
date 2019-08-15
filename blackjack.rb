# frozen_string_literal: true

require_relative 'card.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'game.rb'

class Blackjack
  MENU = ['0. Open cards', '1. Stand', '2. Hit'].freeze
  OPTIONS = %i[open_cards stand hit].freeze

  def initialize
    @dealer = Dealer.new
  end

  def main
    enter unless @game

    @game.over? ? winner_notice : action
    main
  end

  private

  def enter
    puts 'Enter your name'
    @player = Player.new(gets.chomp)
    @game = Game.new(@player, @dealer)
    @game.start
  end

  def menu
    @player.hand_full? ? MENU[0...-1] : MENU
  end

  def options
    @player.hand_full? ? OPTIONS[0...-1] : OPTIONS
  end

  def action
    @game.playing == @player ? request_input : dealer_logic
  end

  def request_input
    puts game_state
    puts menu
    @game.public_send options[gets.to_i] || :do_nothing
  end

  def dealer_logic
    @dealer.score < 17 ? @game.hit : @game.stand
  end

  def winner_notice
    puts game_state
    puts @game.winner ? "#{@game.winner.name} wins!" : 'Tie!'
    play_again
  end

  def play_again
    puts 'Input y to play again or anything else to exit'
    abort if gets.chomp !~ /\s*y\s*/i
    @game.start
  end

  def game_state
    [@dealer, @player, "Cash: #{@player.cash}, bank: #{@game.bank}"]
  end
end
