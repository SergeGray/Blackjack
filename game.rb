# frozen_string_literal: true

class Game
  attr_reader :playing

  class << self
    attr_accessor :deck
    @deck = Card.deck.shuffle
  end

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

  def add_card
    @playing.hand << @deck.pop
    open_cards if @playing.score > 21
    next_turn
  end

  def open_cards
    players.each(&:show_hand)
    tally
    reshuffle_deck
  end

  def tally
    winner ? pay(winner) : refund
  end

  def winner
    players.select do |player|
      player.effective_score > other_player(player).effective_score
    end
  end

  def start
    players.each do |player|
      player.hand = self.class.deck.pop(2)
      player.wallet -= bet
      @bank += bet
    end
  end

  alias skip_turn next_turn

  private

  def reshuffle_deck
    players.each { |player| self.class.deck += player.hand.pop(3) }
    deck.shuffle
  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end

  def pay(player)
    @bank -= bet * 2
    player.wallet += bet * 2
  end

  def refund
    @bank -= bet * 2
    players.each { |player| player.wallet += bet }
  end
end
