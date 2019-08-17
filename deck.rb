# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit, _|
      Card::NOMINALS.each do |name, _|
        @cards << Card.new(suit, name)
      end
    end
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
