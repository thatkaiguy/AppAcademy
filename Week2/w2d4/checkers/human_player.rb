class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    self.color.to_s
  end

  def get_position
    pos = gets.chomp.split(",").map(&:to_i)
  end

end
