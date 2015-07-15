require 'rspec'
require 'deck'
require 'byebug'

describe Deck do

  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "is a deck of 52 cards" do
      expect(deck.count).to eq(52)
    end
  end

  describe "#count" do
    it "counts the number of cards in a used deck" do
      deck.give_card(3)
      expect(deck.count).to eq(49)
    end
  end

  describe "#shuffle" do
    it "shuffles the deck" do
      deck.shuffle
      expect(deck.cards).to_not eq(Deck.new.cards)
    end
  end

  describe "#reset_deck" do
    it "gives a new deck" do
      expect(deck.reset_deck).to eq(Deck.new.cards)
    end
  end

  describe "#give_card" do
    let(:card) {deck.give_card}
    it "gives out a single card" do
      expect(card.count).to eq(1)
      expect(card.first.class).to eq(Card)
    end

    it "gives out multiple cards" do
      expect(deck.give_card(5).count).to eq(5)
    end


  end

end
