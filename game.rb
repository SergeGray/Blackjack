# frozen_string_literal: true

require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'

class Game
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

  def action
    send menu || :do_nothing
  end

  def menu
    @player.hand.full? ? @interface.open_menu : @interface.menu
  end

  def state
    @players.reverse + ["Cash: #{@player.cash}, bank: #{bank}"]
  end

  def next_turn
    @playing = next_player(@playing)
    dealer_logic if @playing.dealer?
  end

  alias stand next_turn

  def hit
    @playing.hand.grab(@deck.draw) unless @playing.hand.full?
    open_cards if next_player(@playing).hand.full?
    next_turn
  end

  def open_cards
    @revealed = @players.select(&:hidden?).each(&:reveal_hand)
    tally
  end

  def winner
    @players.find do |player|
      player.effective_score > next_player(player).effective_score
    end
  end

  def endgame_notice
    winner ? "#{winner.name} wins!" : 'Tie!'
  end

  def start
    hide_cards
    shuffle_deck
    @playing = @player
    deal
  end

  def play_again
    @interface.output(endgame_notice)
    @interface.play_again ? start : abort
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

  def next_player(player)
    @players.at(@players.index(player).next) || @players[0]
  end

  def pay(player)
    @players.size.times { payout(player) }
  end

  def refund
    @players.each { |player| payout(player) }
  end

  def make_bet(player)
    player.cash -= @bet
    @bank += @bet
  end

  def payout(player)
    @bank -= @bet
    player.cash += @bet
  end
end
