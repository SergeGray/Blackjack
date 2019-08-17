# frozen_string_literal: true

class MoneyAccount
  attr_reader :cash

  def initialize(cash = 0)
    @cash = cash
  end

  def transfer(to, amount)
    raise ArgumentError, 'Not enough money in the account' if @cash < amount
    @cash -= amount
    to.cash += amount
  end

  def empty?
    @cash.zero?
  end

  def to_s
    "#{@cash}"
  end

  protected

  attr_writer :cash
end
