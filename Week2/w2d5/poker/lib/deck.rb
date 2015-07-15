require_relative 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = new_deck
  end

  def count
    cards.count
  end

  def give_card(num = 1)
    num == 1 ? [cards.shift] : cards.shift(num)
  end

  def shuffle
    cards.shuffle!
  end

  def reset_deck
    @cards = new_deck
  end


  private

  def new_deck
    cards = []
    Card::SUITS.keys.each do |suit|
      Card::VALUES.keys.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end
end
