# frozen_string_literal: true

class Game
  attr_reader :playing, :bank

  class << self
    attr_accessor :deck
  end

  @deck = Card.deck

  def initialize(player1, player2, bet = 10)
    @player1 = player1
    @player2 = player2
    @playing = player1
    @bet = bet
    @bank = 0
  end

  def players
    [@player1, @player2]
  end

  def next_turn
    @playing = other_player(@playing)
  end

  def hit
    unless @playing.hand_full?
      @playing.hand << self.class.deck.pop
      open_cards if @playing.score > 21
    end
    next_turn
  end

  def open_cards
    @revealed = players.select(&:hidden?).each(&:show_hand)
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
    arrange_table
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

  def hide_cards
    @revealed&.each(&:hide_hand)
  end

  def shuffle_deck
    players.each { |player| self.class.deck += player.hand.pop(3) }
    self.class.deck.shuffle!
  end

  def arrange_table
    players.each do |player|
      player.hand = self.class.deck.pop(2)
      player.cash -= @bet
      @bank += @bet
    end
  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end

  def pay(player)
    @bank -= @bet * 2
    player.cash += @bet * 2
  end

  def refund
    @bank -= @bet * 2
    players.each { |player| player.cash += @bet }
  end
end
