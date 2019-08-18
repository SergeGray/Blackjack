# frozen_string_literal: true

module Blackjack
  class Player
    attr_accessor :hand
    attr_reader :name, :wallet

    def initialize(name, cash = 100, hidden: false)
      @name = name
      @wallet = MoneyAccount.new(cash)
      @hand = Hand.new(hidden: hidden)
    end

    def score
      @hand.score
    end

    def effective_score
      score > 21 ? 0 : score
    end

    def dealer?
      false
    end

    def hidden?
      @hand.hidden?
    end

    def hide_hand
      @hand.hide
    end

    def reveal_hand
      @hand.reveal
    end

    def view_hand
      @hand.view
    end

    def view_score
      hidden? ? '**' : score
    end
  end
end
