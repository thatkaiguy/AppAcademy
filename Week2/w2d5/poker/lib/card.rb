class Card

  SUITS = {"♠" => 4,
           "♥" => 3,
           "♣" => 2,
           "♦" => 1}

  VALUES = {"2" => 2,
            "3" => 3,
            "4" => 4,
            "5" => 5,
            "6" => 6,
            "7" => 7,
            "8" => 8,
            "9" => 9,
            "10" => 10,
            "J" => 11,
            "Q" => 12,
            "K" => 13,
            "A" => 14}

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def ==(other_card)
    @suit == other_card.suit && @value == other_card.value
  end

  def <=>(other_card)
    sort_value <=> other_card.sort_value
  end

  def sort_value
    VALUES[@value]
  end

  def sort_suit
    SUITS[@suit]
  end

end
