require_relative 'stepping_piece'

class Pawn < SteppingPiece

  attr_accessor :moved

  def initialize(board, pos, color = nil, moved =  false)
    super(board, pos, color)
    @moved = moved
  end

  def pos=(pos)
    @pos = pos
    @moved = true
  end

  def dup(new_board)
    self.class.new(new_board, pos.dup, color, moved)
  end

  def differentials
    diffs = [
      [ 1,  0],
      [ 2,  0],
      [ 1,  1],
      [ 1, -1]
    ]
    if self.color != self.board.color1
      diffs.map! do |diff|
        [-diff.first, -diff.last]
      end
    end

    diffs
  end

  def valid_moves
    all_valids = super
    row, col = pos
    forward_move = [row + differentials[0].first, col + differentials[0].last]
    jump_move = [row + differentials[1].first, col + differentials[1].last]
    diag_move_1 = [row + differentials[2].first, col + differentials[2].last]
    diag_move_2 = [row + differentials[3].first, col + differentials[3].last]

    all_valids.reject do |move|

      move == forward_move && self.board.occupied?(*forward_move) ||
      move == jump_move && ( self.moved || self.board.occupied?(*jump_move) ) ||
      move == diag_move_1 && !self.board.occupied?(*diag_move_1) ||
      move == diag_move_2 && !self.board.occupied?(*diag_move_2)
    end
  end

  def symbolize
    " ♟ ".colorize(:color => self.color)
  end

end
