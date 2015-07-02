require_relative 'stepping_piece'

class Knight < SteppingPiece

  def differentials
    [
      [ 2,  1],
      [ 2, -1],
      [ 1,  2],
      [-1,  2],
      [-2,  1],
      [-2, -1],
      [ 1, -2],
      [-1, -2]
    ]
  end

  def symbolize
    " ♞ ".colorize(:color => self.color)
  end

end
