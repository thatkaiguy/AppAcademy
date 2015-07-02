require_relative 'piece'

class TestPiece < Piece

  def valid_moves
    board.empty_positions()
  end

  def inspect
    "[*]"
  end
end
