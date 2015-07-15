require 'rspec'
require 'card'

describe Card do

  describe "#initialize" do
    subject(:card) {Card.new("♠", "4")}


    it "is assigned a suit" do
      expect(card.suit).to eq("♠")
    end

    it "is assigned a value" do
      expect(card.value).to eq("4")
    end
  end

end
