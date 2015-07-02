require_relative 'piece'
require 'byebug'

class SteppingPiece < Piece

  def possible_moves
    possible_moves = []
    # debugger
    row, col = pos
    differentials.each do |diff|
      new_row = row + diff.first
      new_col = col + diff.last
      possible_moves << [new_row, new_col] if board.on_board?(new_row, new_col)
    end

    possible_moves
  end

  def valid_moves
    possible_moves.reject do |pos|
      board.occupied?(*pos) && self.color == board.color(*pos)
    end
  end

end
