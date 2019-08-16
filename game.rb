# frozen_string_literal: true

class Game
  attr_reader :playing, :bank, :deck

  def initialize(player1, player2, bet = 10)
    @player1 = player1
    @player2 = player2
    @deck = Deck.new
    @bet = bet
    @bank = 0
  end

  def players
    [@player1, @player2]
  end

  def next_turn
    @playing = other_player(@playing)
    dealer_logic if @playing.dealer?
  end

  def hit
    @playing.hand.grab(@deck.draw) unless @playing.hand.full?
    open_cards if other_player(@playing).hand.full?
    next_turn
  end

  def open_cards
    @revealed = players.select(&:hidden?).each(&:reveal_hand)
    tally
  end

  def winner
    players.find do |player|
      player.effective_score > other_player(player).effective_score
    end
  end

  def start
    hide_cards
    shuffle_deck
    @playing = @player1
    deal
  end

  def over?
    @bank.zero?
  end

  def do_nothing; end

  alias stand next_turn

  private

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
    players.each { |player| @deck.retrieve(player.hand.discard) }
    @deck.shuffle
  end

  def deal
    players.each do |player|
      player.hand.grab(@deck.draw(2))
      make_bet(player)
    end
  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end

  def pay(player)
    2.times { payout(player) }
  end

  def refund
    players.each { |player| payout(player) }
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
