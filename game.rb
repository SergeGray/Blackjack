# frozen_string_literal: true

require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'payment.rb'

class Game
  include Payment

  TURNS = %i[open_cards stand hit].freeze

  attr_reader :playing, :bank, :deck

  def initialize(interface:, bet: 10)
    @interface = interface
    @deck = Deck.new
    @dealer = Dealer.new
    @bet = bet
    @bank = 0
  end

  def main
    enter unless entered?

    @interface.output(state)
    over? ? play_again : action
    main
  end

  private

  def enter
    @player = Player.new(@interface.name)
    @players = [@player, @dealer]
    start
  end

  def entered?
    @player ? true : false
  end

  def start
    hide_cards
    shuffle_deck
    @playing = @player
    deal
  end

  def hide_cards
    @revealed&.each(&:hide_hand)
  end

  def shuffle_deck
    @players.each { |player| @deck.retrieve(player.hand.discard) }
    @deck.shuffle
  end

  def deal
    @players.each do |player|
      player.hand.grab(@deck.draw(2))
      make_bet(player)
    end
  end

  def action
    menu
    send TURNS[@interface.input.to_i] || :do_nothing
  end

  def menu
    @player.hand.full? ? @interface.open_menu : @interface.menu
  end

  def state
    @players.reverse + ["Cash: #{@player.cash}, bank: #{bank}"]
  end

  def next_turn
    @playing = other_player
    dealer_logic if @playing.dealer?
  end

  alias stand next_turn

  def hit
    return if @playing.hand.full?

    @playing.hand.grab(@deck.draw)
    open_cards if other_player.hand.full?
    next_turn
  end

  def open_cards
    @revealed = @players.select(&:hidden?).each(&:reveal_hand)
    tally
  end

  def other_player(player = @playing)
    player == @player ? @dealer : @player
  end

  def winner
    @players.find do |player|
      player.effective_score > other_player(player).effective_score
    end
  end

  def over?
    @bank.zero?
  end

  def do_nothing; end

  def tally
    winner ? pay(winner) : refund
  end

  def dealer_logic
    @playing.score < 17 ? hit : stand
  end

  def endgame_notice
    winner ? @interface.win_message(winner) : @interface.tie_message
  end

  def play_again
    endgame_notice
    @interface.play_again ? start : abort
  end
end
