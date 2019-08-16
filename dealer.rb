# frozen_string_literal: true

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
