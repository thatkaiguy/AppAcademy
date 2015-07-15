require 'rspec'
require 'array'

describe Array do

  describe "#my_uniq" do
    subject(:test_array) { [1, 2, 1, 3, 3] }

    it "returns the unique elements in the order they appeard" do
      expect(test_array.my_uniq).to eq([1,2,3])
    end
  end

  describe "#two_sum" do
    subject(:test_array) { [-1, 0, 2, -2, 1] }

    it "finds all pairs of positions where the elements sum to zero" do
      expect(test_array.two_sum).to eq([[0, 4], [2, 3]])
    end

  end

  describe "#median" do
    subject(:even_array) { [2, 4, 3, 1] }
    subject(:odd_array) { [2, 4, 3, 1, 5] }

    it "returns the middle number of the sorted odd array" do
      expect(odd_array.median).to eq(3)
    end

    it "returns the middle number of the sorted even array" do
      expect(even_array.median).to eq(2.5)
    end
  end

  describe "#my_transpose" do
    subject(:matrix) {[
                        [0, 1, 2],
                        [3, 4, 5],
                        [6, 7, 8]
                      ]}
    it "transposes" do
      expect(matrix.my_transpose).to eq([[0, 3, 6],
                                         [1, 4, 7],
                                         [2, 5, 8]])
    end

  end

end
