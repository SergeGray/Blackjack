# frozen_string_literal: true

class Player
  attr_accessor :hand, :cash
  attr_reader :name

  def initialize(name, cash = 100, hidden: false)
    @name = name
    @cash = cash
    @hand = Hand.new(hidden: hidden)
  end

  def score
    @hand.score
  end

  def effective_score
    score > 21 ? 0 : score
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

  def to_s
    "#{@name}'s hand: #{view_hand}, score: #{view_score}"
  end

  private

  def view_hand
    @hand.view
  end

  def view_score
    @hand.hidden? ? '**' : score
  end
end
