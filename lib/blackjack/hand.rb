# frozen_string_literal: true

module Blackjack
  class Hand
    attr_accessor :cards

    def initialize(hidden: false)
      @hidden = hidden
      @cards = []
    end

    def score
      non_ace_value + ace_value
    end

    def hidden?
      @hidden
    end

    def reveal
      @hidden = false
    end

    def hide
      @hidden = true
    end

    def full?
      @cards.size == 3
    end

    def view
      (hidden? ? @cards.map { '***' } : @cards).join(' ')
    end

    def grab(cards)
      @cards += cards
    end

    def discard
      @cards.pop(3)
    end

    private

    def non_ace_value
      @cards.reject(&:ace?).reduce(0) { |total, card| total + card.value }
    end

    def ace_value
      return ace_count if ace_count.zero?

      non_ace_value > 11 - ace_count ? ace_count : 10 + ace_count
    end

    def ace_count
      @cards.count(&:ace?)
    end
  end
end
