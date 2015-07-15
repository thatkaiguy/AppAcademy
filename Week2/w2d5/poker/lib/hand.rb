class Hand

  HANDS = {
    :royal_flush  => 9,
    :quadruple    => 8,
    :full_house   => 7,
    :flush        => 6,
    :straight     => 5,
    :triple       => 4,
    :two_pair     => 3,
    :pair         => 2,
    :high_card    => 1
  }


  attr_accessor :cards

  def initialize(deck = nil)
    @cards = deck ? deck.give_card(5) : []
  end

  def <=>(other_hand)
    compare_val = HANDS[self.calculate] <=> HANDS[other_hand.calculate]
    case compare_val
    when 0
      self.tie_breaker(other_hand)
    else
      compare_val
    end
  end

  def calculate
    if royal_flush?
      :royal_flush
    elsif quadruple?
      :quadruple
    elsif full_house?
      :full_house
    elsif flush?
      :flush
    elsif straight?
      :straight
    elsif triples?
      :triple
    elsif two_pair?
      :two_pair
    elsif pair?
      :pair
    else
      :high_card
    end

  end

  def discard(array)
    array.sort!

    until array.empty?
      cards.delete_at(array.pop)
    end

  end

  # private

  def pair?
    cards.map { |card| card.sort_value }.uniq.length == 4
  end

  def two_pair?
    count = Hash.new(0)
    values = cards.map { |card| card.sort_value }
    values.each { |value| count[value] += 1}

    count.values.select { |value| value == 2}.length == 2
  end

  def quadruple?
    count = Hash.new(0)
    values = cards.map { |card| card.sort_value }
    values.each { |value| count[value] += 1}

    count.values.any? { |value| value == 4}
  end

  def triples?
    values = cards.map { |card| card.sort_value }
    values.any? { |value| values.count(value) == 3 }
  end

  def flush?
    cards.map { |card| card.sort_suit }.uniq.length == 1
  end

  def full_house?
    count = Hash.new(0)
    values = cards.map { |card| card.sort_value }
    values.each { |value| count[value] += 1}

    count.values.all? { |value| value >= 2}
  end

  def straight?
   sorted_cards = cards.sort {|c1, c2| c1.sort_value <=> c2.sort_value}
   first_value = sorted_cards.first.sort_value

   values = sorted_cards.map { |card| card.sort_value }

   values == (first_value..first_value + 4).to_a
  end


  def royal_flush?
    suit = cards.first.suit
    royals = ["10", "J", "Q", "K", "A"]

    sorted_cards = cards.sort {|c1, c2| c1.sort_value <=> c2.sort_value}
    values = sorted_cards.map { |card| card.value }

    cards.all? {|card| card.suit == suit} && (royals == values)
  end

  def tie_breaker(other_hand)

    my_hand = self.calculate

    if my_hand == :royal_flush
      1
    elsif my_hand == :quadruple
      own_cards = find_repeated_cards
      other_cards = other_hand.find_repeated_card
      own_cards.first > other_cards.first ? 1 : -1
    elsif my_hand == :full_house
      own_cards = find_repeated_cards
      other_cards = other_hand.find_repeated_card
      own_cards > other_cards ? 1 : -1
    elsif my_hand == :flush
      self.cards.sort.last > other_hand.cards.sort.last ? 1 : -1
      #doesn't compare next highest yet
    elsif my_hand == :straight
      return 0 if self.cards.sort.last == other_hand.cards.sort.last
      self.cards.sort.last > other_hand.cards.sort.last ? 1 : -1
    elsif my_hand == :triple
      own_cards = find_repeated_cards
      other_cards = other_hand.find_repeated_cards
      own_cards > other_cards ? 1 : -1
    elsif my_hand == :two_pair
      own_pairs = find_repeated_cards
      other_pairs = other_hand.find_repeated_cards
      if own_pairs.last == other_pairs.last
        return 0 if own_pairs.first == other_pairs.first
        own_pairs.first > other_pairs.first ? 1 : -1
      else
        own_pairs.last == other_pairs.last ? 1 : - 1
      end
    elsif my_hand == :pair
      own_pair = find_repeated_cards
      other_pair = other_hand.find_repeated_cards

      return 0 if own_pair.first == other_pair.first
      own_pair.first > other_pair.first ? 1 : -1
    else
      own_values = cards.map { |card| card.sort_value }.sort.reverse
      other_values = other_hand.cards.map { |card| card.sort_value }.sort.reverse

      own_values.each_with_index do |value, idx|
        next if value == other_values[idx]
        return value > other_values[idx] ? 1 : -1
      end

    end

  end

  def find_repeated_cards
    my_hand = self.calculate
    if my_hand == :quadruple
      values = cards.map { |card| card.sort_value }
      values.select { |value| return value if values.count(value) == 4 }
    elsif my_hand == :full_house || my_hand == :triple
      values = cards.map { |card| card.sort_value }
      values.select { |value| return value if values.count(value) == 3 }
    elsif my_hand == :two_pair
      count = Hash.new(0)
      values = cards.map { |card| card.sort_value }
      values.each { |value| count[value] += 1}
      count.select { |key, value| value == 2}.keys.sort
    elsif my_hand == :pair
      count = Hash.new(0)
      values = cards.map { |card| card.sort_value }
      values.each { |value| count[value] += 1}
      count.select { |key, value| value == 2}.keys
    end

  end



end
