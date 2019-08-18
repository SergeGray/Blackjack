# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Deck do
    let(:deck) { Deck.new }

    describe '.new' do
      it 'fills the deck with 52 different cards' do
        expect(deck.cards.length).to eq(52)
      end
    end

    describe '#shuffle' do
      it 'shuffles the deck' do
        first_card = deck.cards.first
        deck.shuffle
        expect(deck.cards.first).to_not eq(first_card)
      end
    end

    describe '#draw' do
      it 'removes and returns an array of x number of cards from the deck' do
        last_card = deck.cards.last
        expect(deck.draw).to eq([last_card])
        expect(deck.cards.length).to eq(51)
      end
    end

    describe '#retrieve' do
      it 'adds an array of cards to deck' do
        removed = deck.draw(4)
        deck.retrieve(removed)
        expect(deck.cards.length).to eq(52)
      end
    end
  end
end
