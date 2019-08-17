# frozen_string_literal: true

module Payment
  def pay(player)
    @players.size.times { payout(player) }
  end

  def refund
    @players.each { |player| payout(player) }
  end

  def make_bet(player)
    player.cash -= @bet
    @bank += @bet
  end

  def payout(player)
    @bank -= @bet
    player.cash += @bet
  end
end
