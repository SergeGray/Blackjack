# frozen_string_literal: true

class Card
  SUITS = {
    hearts: "\u2665",
    diamonds: "\u2666",
    clubs: "\u2660",
    spades: "\u2663"
  }.freeze
  NAMES = {
    two: ' 2',
    three: ' 3',
    four: ' 4',
    five: ' 5',
    six: ' 6',
    seven: ' 7',
    eight: ' 8',
    nine: ' 9',
    ten: '10',
    jack: ' J',
    queen: ' Q',
    king: ' K',
    ace: ' A'
  }.freeze

  attr_reader :suit, :name

  def self.deck
    SUITS.map { |suit, _| NAMES.map { |name, _| new(suit, name) } }.flatten
  end

  def initialize(suit, name)
    @suit = suit
    @name = name
  end

  def to_s
    "#{NAMES[name]}#{SUITS[suit]}"
  end
end
