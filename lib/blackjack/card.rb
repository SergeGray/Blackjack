# frozen_string_literal: true

module Blackjack
  class Card
    SUITS = {
      hearts: "\u2665",
      diamonds: "\u2666",
      clubs: "\u2660",
      spades: "\u2663"
    }.freeze
    NOMINALS = {
      two: { string: ' 2', value: 2 },
      three: { string: ' 3', value: 3 },
      four: { string: ' 4', value: 4 },
      five: { string: ' 5', value: 5 },
      six: { string: ' 6', value: 6 },
      seven: { string: ' 7', value: 7 },
      eight: { string: ' 8', value: 8 },
      nine: { string: ' 9', value: 9 },
      ten: { string: '10', value: 10 },
      jack: { string: ' J', value: 10 },
      queen: { string: ' Q', value: 10 },
      king: { string: ' K', value: 10 },
      ace: { string: ' A', value: 11 }
    }.freeze

    attr_reader :suit, :name

    def initialize(suit, name)
      raise ArgumentError, 'Invalid suit' unless SUITS.keys.include?(suit)
      raise ArgumentError, 'Invalid name' unless NOMINALS.keys.include?(name)

      @suit = suit
      @name = name
    end

    def value
      NOMINALS[name][:value]
    end

    def ace?
      @name == :ace
    end

    def to_s
      "#{NOMINALS[name][:string]}#{SUITS[suit]}"
    end
  end
end
