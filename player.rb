# frozen_string_literal: true

class Player
  attr_accessor :hand, :wallet

  def initialize(wallet = 100, hidden = false)
    @wallet = wallet
    @hidden = hidden
  end

  def score
    @hand.reduce(0) do |score, card|
      score + card.ace? ? ace_count(score) : card.value
    end
  end

  def effective_score
    score > 21 ? 0 : score
  end

  def hidden?
    @hidden
  end

  def show_hand
    @hidden = false
  end

  def view_hand
    hidden? ? @hand.map { '***' } : @hand
  end

  private

  def ace_count(score)
    score > 10 ? 1 : 11
  end
end
