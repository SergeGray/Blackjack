class Card
  SUITS = %i[ hearts diamonds clubs spades ].freeze
  NAMES = %i[
    two three four five six seven eight
    nine ten jack queen king ace
  ].freeze

  attr_reader :suit, :name

  def self.deck
    SUITS.map { |suit| NAMES.map { |name| self.new(suit, name) } }
  end

  def initialize(suit, name)
    @suit = suit
    @name = name
  end
end
