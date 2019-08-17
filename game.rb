# frozen_string_literal: true

class Game
  include GameHelper

  TURNS = %i[open_cards stand hit].freeze

  attr_reader :playing, :bank, :deck

  def initialize(interface:, bet: 10)
    @interface = interface
    @deck = Deck.new
    @dealer = Dealer.new
    @bank = MoneyAccount.new
    @bet = bet
  end

  def main
    enter unless entered?

    @interface.state_message(@player, @dealer, @bank)
    over? ? play_again : action
    main
  end

  private

  def enter
    @player = Player.new(@interface.name)
    @players = [@player, @dealer]
    start
  end

  def entered?
    @player ? true : false
  end

  def start
    hide_cards
    shuffle_deck
    @playing = @player
    deal
  end

  def hide_cards
    @revealed&.each(&:hide_hand)
  end

  def shuffle_deck
    @players.each { |player| @deck.retrieve(player.hand.discard) }
    @deck.shuffle
  end

  def deal
    @players.each do |player|
      player.hand.grab(@deck.draw(2))
      player.wallet.transfer(@bank, @bet)
    end
  end

  def action
    menu
    send TURNS[@interface.choice] || :do_nothing
  end

  def next_turn
    @playing = other_player
    dealer_logic if @playing.dealer?
  end

  alias stand next_turn

  def hit
    return if @playing.hand.full?

    @playing.hand.grab(@deck.draw)
    open_cards if other_player.hand.full?
    next_turn
  end

  def open_cards
    @revealed = @players.select(&:hidden?).each(&:reveal_hand)
    tally
  end

  def other_player(player = @playing)
    player == @player ? @dealer : @player
  end

  def winner
    @players.find do |player|
      player.effective_score > other_player(player).effective_score
    end
  end

  def tally
    winner ? pay(winner) : refund
  end

  def dealer_logic
    @playing.score < 17 ? hit : stand
  end

  def play_again
    endgame_notice
    bankrupt if @player.wallet.empty?
    @interface.play_again ? start : abort
  end

  def bankrupt
    @interface.bankrupt
    abort
  end

  def pay(player)
    @players.size.times { @bank.transfer(player.wallet, @bet) }
  end

  def refund
    @players.each { |player| @bank.transfer(player.wallet, @bet) }
  end
end
