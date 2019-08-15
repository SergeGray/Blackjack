# frozen_string_literal: true

class Player
  attr_accessor :hand, :cash
  attr_reader :name

  def initialize(name, cash = 100, options = {})
    @name = name
    @cash = cash
    @hidden = options[:hidden] || false
    @hand = []
  end

  def score
    @hand.reduce(0) do |score, card|
      score + (card.ace? ? ace_count(score) : card.value)
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

  def hide_hand
    @hidden = true
  end

  def view_hand
    (hidden? ? @hand.map { '***' } : @hand).join(' ')
  end

  def view_score
    hidden? ? '**' : score
  end

  def hand_full?
    @hand.size == 3
  end

  private

  def ace_count(score)
    score > 10 ? 1 : 11
  end
end
