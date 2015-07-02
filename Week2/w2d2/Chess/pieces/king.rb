require_relative 'stepping_piece'

class King < SteppingPiece

  DIFFERENTIALS = [
      [ 1,  1],
      [ 1, -1],
      [-1,  1],
      [-1, -1],
      [ 0,  1],
      [ 1,  0],
      [-1,  0],
      [ 0, -1]
    ]

  def differentials
    DIFFERENTIALS
  end

  def symbolize
    " ♚ ".colorize(:color => self.color)
  end

end
