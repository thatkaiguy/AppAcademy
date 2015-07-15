require 'rspec'
require 'hand'
require 'deck'
require 'card'

describe Hand do

  describe "#initialize" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck) }

    it "starts out with five cards" do

      expect(hand.cards.count).to eq(5)
    end

  end

  describe "#calculate" do

    subject(:hand) { Hand.new }
    let(:full_house_set) { [Card.new("♠", "4"),
                            Card.new("♥", "4"),
                            Card.new("♦", "4"),
                            Card.new("♠", "7"),
                            Card.new("♥", "7") ]}
    let(:flush_set)  {[Card.new("♠", "4"),
                       Card.new("♠", "10"),
                       Card.new("♠", "8"),
                       Card.new("♠", "7"),
                       Card.new("♠", "6") ]}
    let(:r_flush_set)  {[Card.new("♠", "A"),
                         Card.new("♠", "K"),
                         Card.new("♠", "Q"),
                         Card.new("♠", "J"),
                         Card.new("♠", "10") ]}
    let(:straight_set)  {[Card.new("♠", "6"),
                         Card.new("♣", "7"),
                         Card.new("♥", "8"),
                         Card.new("♠", "9"),
                         Card.new("♥", "10") ]}
    let(:triple_set) { [Card.new("♠", "4"),
                        Card.new("♦", "4"),
                        Card.new("♥", "4"),
                        Card.new("♠", "7"),
                        Card.new("♣", "9") ]}
    let(:two_pair_set)  {[Card.new("♠", "4"),
                          Card.new("♣", "4"),
                          Card.new("♣", "10"),
                          Card.new("♥", "10"),
                          Card.new("♠", "6") ]}
    let(:pair_set)  {[Card.new("♠", "4"),
                      Card.new("♥", "4"),
                      Card.new("♠", "8"),
                      Card.new("♠", "7"),
                      Card.new("♠", "6") ]}
    let(:high_card_set)  { [Card.new("♠", "10"),
                            Card.new("♥", "A"),
                            Card.new("♠", "8"),
                            Card.new("♥", "7"),
                            Card.new("♠", "3") ]}
    let(:quad_set) {[Card.new("♠", "10"),
                    Card.new("♥", "10"),
                    Card.new("♦", "10"),
                    Card.new("♣", "10"),
                    Card.new("♠", "3") ]}


    it "finds the strongest hand" do
      hand.cards = full_house_set

      expect(hand.calculate).to eq(:full_house)
    end

    it "finds a quadruple set" do
      hand.cards = quad_set

      expect(hand.calculate).to eq(:quadruple)
    end

    it "finds a full house" do
      hand.cards = full_house_set

      expect(hand.calculate).to eq(:full_house)
    end


    it "finds a flush" do
      hand.cards = flush_set

      expect(hand.calculate).to eq(:flush)
    end

    it "finds a royal flush" do
      hand.cards = r_flush_set

      expect(hand.calculate).to eq(:royal_flush)
    end

    it "finds a straight" do
      hand.cards = straight_set

      expect(hand.calculate).to eq(:straight)

    end

    it "finds a set (trips)" do
      hand.cards = triple_set

      expect(hand.calculate).to eq(:triple)

    end

    it "finds two pairs" do
      hand.cards = two_pair_set

      expect(hand.calculate).to eq(:two_pair)

    end

    it "finds one pair" do
      hand.cards = pair_set

      expect(hand.calculate).to eq(:pair)

    end

    it "gets the highest card" do
      hand.cards = high_card_set

      expect(hand.calculate).to eq(:high_card)
    end
  end

  describe "#discard" do

    subject(:hand) { Hand.new }
    let(:two_pair_set)  {[Card.new("♠", "4"),
                          Card.new("♣", "4"),
                          Card.new("♣", "10"),
                          Card.new("♥", "10"),
                          Card.new("♠", "6") ]}

    it "discards a card you choose" do
      hand.cards = two_pair_set
      hand.discard([4])
      expect(hand.cards).to eq(two_pair_set[0..3])
    end

    it "discards multiple chosen cards" do
      hand.cards = two_pair_set
      hand.discard([3,4])
      expect(hand.cards).to eq(two_pair_set[0..2])

    end

  end

  describe '#<=>' do
    subject(:two_pair_hand) { Hand.new }
    let(:two_pair_set)  {[Card.new("♠", "4"),
                          Card.new("♣", "4"),
                          Card.new("♣", "10"),
                          Card.new("♥", "10"),
                          Card.new("♠", "6") ]}

    subject(:high_card_hand) { Hand.new }
    let(:high_card_set)  { [Card.new("♠", "10"),
                          Card.new("♥", "A"),
                          Card.new("♠", "8"),
                          Card.new("♥", "7"),
                          Card.new("♠", "3") ]}

    subject(:full_house_hand) { Hand.new }
    let(:full_house_set) { [Card.new("♠", "4"),
                            Card.new("♥", "4"),
                            Card.new("♦", "4"),
                            Card.new("♠", "7"),
                            Card.new("♥", "3") ]}

    subject(:r_flush_hand) { Hand.new }
    # let(:r_flush_set)  {[Card.new("♠", "A"),
    #                      Card.new("♠", "K"),
    #                      Card.new("♠", "Q"),
    #                      Card.new("♠", "J"),
    #                      Card.new("♠", "10") ]}
    let(:r_flush_set)  {[Card.new("♥", "6"),
                         Card.new("♦", "6"),
                         Card.new("♠", "6"),
                         Card.new("♠", "J"),
                         Card.new("♠", "10") ]}


    it "sorts hands by rank" do
        two_pair_hand.cards = two_pair_set
        high_card_hand.cards = high_card_set
        full_house_hand.cards = full_house_set
        r_flush_hand.cards = r_flush_set

      expect([two_pair_hand, high_card_hand, full_house_hand,
        r_flush_hand].sort).to eq([high_card_hand, two_pair_hand,
          full_house_hand, r_flush_hand])

    end

  end

end
