# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = Card.deck
  end

  def shuffle
    @cards.shuffle!
  end

  def draw(number = 1)
    @cards.pop(number)
  end

  def retrieve(cards)
    @cards += cards
  end
end
