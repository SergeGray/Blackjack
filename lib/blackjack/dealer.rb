# frozen_string_literal: true

module Blackjack
  class Dealer < Player
    def initialize
      super('Dealer', 1_000_000, hidden: true)
    end

    def dealer?
      true
    end

    def effective_score
      score > 21 ? 1 : score
    end
  end
end
