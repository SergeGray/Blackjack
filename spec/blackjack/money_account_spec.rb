# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe MoneyAccount do
    let(:account1) { MoneyAccount.new(20) }
    let(:account2) { MoneyAccount.new(0) }

    describe '#transfer' do
      it 'sends the amount from account to a different account' do
        account1.transfer(account2, 10)
        expect(account1.cash).to eq(account2.cash)
      end

      it "raises ArgumentError if there's no cash on the sending account" do
        expect { account2.transfer(account1, 10) }.to raise_error(ArgumentError)
      end
    end
  end
end
