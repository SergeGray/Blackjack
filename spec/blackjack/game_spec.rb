# frozen_string_literal: true

require 'spec_helper'

module Blackjack
  describe Game do
    let(:interface) { double('interface') }
    let(:game) { Game.new(interface: interface) }

    before(:each) do
      TerminalInterface.instance_methods(false).each do |method|
        allow(interface).to receive(method)
      end
    end

    describe '#main' do
      context 'upon entering' do
        before(:each) do
          allow(game).to receive(:start)
        end

        after(:each) do
          game.main
        end

        it 'calls Game#enter' do
          expect(game).to receive(:enter)
        end

        it 'enters and starts the game' do
          allow(interface).to receive(:name).and_return('Bob')
          expect(game).to receive(:start)
        end
      end

      context 'upon starting' do
        before(:each) do
          allow(interface).to receive(:name).and_return('Bob')
          allow(game).to receive(:deal)
        end

        it 'attempts to hide previously revealed cards' do
          expect(game).to receive(:hide_cards)
          game.main
        end

        it 'shuffles the deck' do
          expect(game).to receive(:shuffle_deck)
          game.main
        end

        it 'assigns current player' do
          game.main
          expect(game.playing).to_not be_nil
        end

        it 'gives players 2 cards each' do
          skip
        end
      end
    end
  end
end
