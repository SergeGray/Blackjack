# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Hand do
    let(:hand) { Hand.new }
    let(:cards) do
      [
        Card.new(:diamonds, :queen),
        Card.new(:clubs, :seven),
        Card.new(:hearts, :ace)
      ]
    end

    describe '#score' do
      context 'without aces' do
        it 'returns combined card value' do
          hand.cards = cards[0...-1]
          expect(hand.score).to eq(17)
        end
      end

      context 'with aces' do
        it "calculates ace value as 11 if it doesn't put you over 21" do
          hand.cards = cards[1..-1]
          expect(hand.score).to eq(18)
        end

        it 'calculates ace value as 1 if 11 puts you over 21' do
          hand.cards = cards
          expect(hand.score).to eq(18)
        end
      end
    end

    describe '#view' do
      it "returns card string if hand isn't hidden" do
        hand.cards = cards
        expect(hand.view).to eq(" Q\u2666  7\u2660  A\u2665")
      end

      it 'substitutes card strings with asterisks if hand is hidden' do
        hand.cards = cards
        hand.hide
        expect(hand.view).to eq('*** *** ***')
      end
    end

    describe '#grab' do
      it 'adds an array of cards to hand' do
        hand.grab(cards)
        expect(hand.cards).to eq(cards)
      end
    end

    describe '#discard' do
      it 'removes up to 3 cards from hand' do
        hand.cards = cards
        hand.discard
        expect(hand.cards).to be_empty
      end
    end
  end
end
