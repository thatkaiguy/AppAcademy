class EmptySquare

  def initialize
  end

  def empty?
    true
  end

  def king?
    false
  end

  def render
    "   "
  end

  def slide_move(end_pos)
    raise "Trying to slide an empty square."
  end

  def jump_move(*end_positions)
    raise "Trying to jump an empty square"
  end

  def valid_moves
    []
  end

  def color
    :none
  end

end
