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
    non_ace_value + ace_value
  end

  def effective_score
    score > 21 ? 0 : score
  end

  def hidden?
    @hidden
  end

  def reveal_hand
    @hidden = false
  end

  def hide_hand
    @hidden = true
  end

  def hand_full?
    @hand.size == 3
  end

  def to_s
    "#{@name}'s hand: #{view_hand}, score: #{view_score}"
  end

  private

  def non_ace_value
    @hand.reject(&:ace?).reduce(0) { |total, card| total + card.value }
  end

  def ace_value
    return ace_count if ace_count.zero?

    non_ace_value > 11 - ace_count ? ace_count : 10 + ace_count
  end

  def ace_count
    @hand.count(&:ace?)
  end

  def view_hand
    (hidden? ? @hand.map { '***' } : @hand).join(' ')
  end

  def view_score
    hidden? ? '**' : score
  end
end
