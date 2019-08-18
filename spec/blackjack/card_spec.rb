# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Card do
    describe '.new' do
      it 'raises ArgumentError if suit is incorrect' do
        expect { Card.new(:dog, :ace) }.to raise_error(
          ArgumentError, 'Invalid suit'
        )
      end

      it 'raises ArgumentError if name is incorrect' do
        expect { Card.new(:hearts, :eleven) }.to raise_error(
          ArgumentError, 'Invalid name'
        )
      end
    end

    describe '#ace' do
      it 'detects aces' do
        ace = Card.new(:hearts, :ace)
        expect(ace.ace?).to be true
      end

      it "doesn't falsely detect non-aces" do
        not_ace = Card.new(:clubs, :two)
        expect(not_ace.ace?).to be false
      end
    end

    describe '#to_s' do
      it 'returns a card string' do
        card = Card.new(:spades, :ace)
        expect(card.to_s).to eq(" A\u2663")
      end
    end
  end
end
