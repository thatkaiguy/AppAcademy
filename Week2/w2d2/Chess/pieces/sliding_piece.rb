require_relative 'piece'

class SlidingPiece < Piece

  def valid_moves
    valid_moves = []

    directionals.each do |direction|
      valid_moves.concat(possible_slide_moves(direction))
    end

    valid_moves
  end

  def possible_slide_moves(direction)
    moves_in_direction = []
    dir_row, dir_col = direction
    cur_row, cur_col = pos
    new_row, new_col = cur_row + dir_row, cur_col + dir_col

    while board.on_board?(new_row, new_col)
      moves_in_direction << [new_row, new_col]
      break if board.occupied?(new_row, new_col)
      new_row += dir_row
      new_col += dir_col
    end
    moves_in_direction.reject do |pos|
      board.occupied?(*pos) && self.color == board.color(*pos)
    end
  end

end
