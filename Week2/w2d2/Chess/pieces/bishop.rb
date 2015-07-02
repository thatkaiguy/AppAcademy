require_relative 'sliding_piece'

class Bishop < SlidingPiece

  def directionals
    [
      [ 1,  1],
      [ 1, -1],
      [-1,  1],
      [-1, -1]
    ]
  end

  def symbolize
    " ♝ ".colorize(:color => self.color)
  end

end
