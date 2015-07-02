
class Piece

  def initialize(board, pos, color, is_king = false)
    unless board::COLOR1 == color || board::COLOR2 == color
      raise "Invalid color"
    end

    @board = board
    @pos = pos
    @color = color
    @is_king = is_king
  end

  def king?
    @is_king
  end

  def empty?
    false
  end

  def render
    if self.is_king?

    else
      self.color == board::COLOR1 ? " ◉ " : " ◎ "
    end
  end
end
