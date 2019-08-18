# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Player do
    let(:player) { Player.new('Bob') }
    let(:cards) do
      [
        Card.new(:diamonds, :queen),
        Card.new(:clubs, :king),
        Card.new(:hearts, :jack)
      ]
    end

    before(:each) do
      player.hand.cards = cards
    end
    describe '#effective_score' do
      it 'returns score if score is equal or less than 21' do
        player.hand.cards.pop
        expect(player.effective_score).to eq(player.score)
      end

      it 'returns 0 if score is bigger than 21' do
        expect(player.effective_score).to eq(0)
      end
    end

    describe '#view_score' do
      it 'returns score if hand is not hidden' do
        expect(player.view_score).to eq(player.score)
      end

      it 'returns asterisks if hand is hidden' do
        player.hide_hand
        expect(player.view_score).to eq('**')
      end
    end
  end
end
