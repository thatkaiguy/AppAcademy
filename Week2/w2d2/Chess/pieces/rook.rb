require_relative 'sliding_piece'

class Rook < SlidingPiece

  def directionals
    [
      [ 0,  1],
      [ 1,  0],
      [-1,  0],
      [ 0, -1]
    ]
  end

  def symbolize
    " ♜ ".colorize(:color => self.color)
  end

end
