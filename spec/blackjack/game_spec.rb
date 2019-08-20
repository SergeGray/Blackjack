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
          allow(game).to receive(:play_again).and_throw(:quit)
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
          allow(game).to receive(:action).and_throw(:quit)
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
          game.main
          expect(game.playing.hand.cards.count).to eq(2)
        end

        it "takes bet from players' wallets" do
          game.main
          expect(game.playing.wallet.cash).to eq(90)
        end

        it 'puts all the bets into the bank' do
          game.main
          expect(game.bank.cash).to eq(20)
        end
      end

      context 'when making first a turn' do
        before(:each) do
          allow(interface).to receive(:name).and_return('Bob')
          allow(game).to receive(:dealer_logic).and_throw(:quit)
        end

        it "doesn't do anything with wrong input" do
          allow(interface).to receive(:choice).and_return(12, 1)
          expect(game).to receive(:do_nothing)
          game.main
        end

        it 'adds a card to players hand when hit option is selected' do
          allow(interface).to receive(:choice).and_return(2)
          allow(game).to receive(:next_turn).and_throw(:quit)
          game.main
          expect(game.playing.hand.cards.count).to eq(3)
        end

        it 'skips a turn when stand option is selected' do
          allow(interface).to receive(:choice).and_return(1)
          game.main
          expect(game.playing.dealer?).to be true
        end

        it 'opens cards when open cards option is selected' do
          allow(interface).to receive(:choice).and_return(0)
          game.main
          expect(game.playing.hidden?).to be false
        end

        it 'gives turn to the dealer afterwards' do
          allow(interface).to receive(:choice).and_return(1)
          expect(game).to receive(:dealer_logic)
          game.main
        end
      end

      context 'when game is over' do
        before(:each) do
          allow(interface).to receive(:name).and_return('Bob')
          allow(interface).to receive(:choice).and_return(0)
          allow(interface).to receive(:play_again).and_throw(:quit)
          allow(game.deck).to receive(:shuffle)
        end

        it 'pays the winner from the bank' do
          game.main
          expect(game.playing.wallet.cash).to eq(110)
          expect(game.bank.cash).to eq(0)
        end

        it 'refunds everyone when there is a tie' do
          allow(game).to receive(:winner)
          game.main
          expect(game.playing.wallet.cash).to eq(100)
          expect(game.bank.cash).to eq(0)
        end

        it 'prompts the player to play again' do
          expect(interface).to receive(:play_again)
          game.main
        end

        it 'starts the game again' do
          allow(interface).to receive(:play_again).and_return(true, false)
          expect(game).to receive(:start).twice.and_call_original
          game.main
        end
      end

      context 'on consecutive games' do
        it 'quits the game if the player is out of money' do
          allow(interface).to receive_messages(
            name: 'Bob', choice: 0, play_again: true
          )
          expect(game).to receive(:bankrupt).and_throw(:quit)
          game.instance_variable_set(:@bet, 100)
          game.main
        end
      end
    end
  end
end
