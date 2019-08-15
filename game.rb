class Game
  attr_reader :playing

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @playing = player1
  end

  def next_turn
    @playing = (@playing == player1 ? player2 : player1)
  end

  def add_card
    @playing.hand << @deck.pop
    next_turn
  end

  def start
    @deck = Card.deck.shuffle
    @player1.hand = @deck.pop(2)
    @player2.hand = @deck.pop(2)
  end

  alias skip_turn next_turn
end
