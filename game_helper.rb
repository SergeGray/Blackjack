# frozen_string_literal: true

module GameHelper
  def menu
    @player.hand.full? ? @interface.open_menu : @interface.menu
  end

  def state
    @players.reverse + ["Cash: #{@player.wallet}, bank: #{@bank}"]
  end

  def over?
    @bank.empty?
  end

  def do_nothing; end

  def endgame_notice
    winner ? @interface.win_message(winner) : @interface.tie_message
  end
end
