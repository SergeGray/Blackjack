# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Dealer do
    let(:dealer) { Dealer.new }
    
    describe '#dealer?' do
      it 'returns true for dealer' do
        expect(dealer.dealer?).to be true
      end
    end

    describe '#effective_score' do
      it 'returns score if score is equal or less than 21' do
        dealer.hand.cards = [Card.new(:clubs, :ace), Card.new(:clubs, :king)]
        expect(dealer.effective_score).to eq(dealer.score)
      end

      it 'returns 1 if score is bigger than 21' do
        dealer.hand.cards = [
          Card.new(:diamonds, :queen),
          Card.new(:clubs, :king),
          Card.new(:hearts, :jack)
        ]
        expect(dealer.effective_score).to eq(1)
      end
    end
  end
end
