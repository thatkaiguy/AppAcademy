require 'byebug'
require 'colorize'

require_relative 'invalid_move_error'

class Piece
  attr_accessor :pos
  attr_reader :color, :board


  def initialize(board, pos, color, is_king = false)
    unless Board::COLOR1 == color || Board::COLOR2 == color
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
    if self.king?

    else
      color = self.color == Board::COLOR1 ? Board::COLOR1 : Board::COLOR2
      " ⬤ ".colorize(:color => color)
    end
  end

  def perform_moves(*end_positions)
    #debugger
    if valid_move_seq?(*end_positions)
      perform_moves!(*end_positions)
    else
      raise InvalidMoveError.new("Invalid move!")
    end
  end

  def valid_move_seq?(*end_positions)
    #debugger
    new_board = self.board.dup
    begin
      new_board[self.pos].perform_moves!(*end_positions)
      true
    rescue InvalidMoveError => error
      puts error.message
      false
    end
  end

  def perform_moves!(*end_positions)
    if end_positions.count > 1
      unless end_positions.all? { |end_pos| jump_move(end_pos) }
        raise InvalidMoveError.new("Invalid move")
      end
    elsif end_positions.count == 1
      end_pos = end_positions.first
      if !jump_move(end_pos) && !slide_move(end_pos)
        raise InvalidMoveError.new("Invalid move")
      end
    else
      #no moves provided
      false
    end
  end

  def slide_move(end_pos)
    if valid_slide_moves.include?(end_pos)
      slide_move!(end_pos)
      true
    else
      false
    end
  end

  # put this as private?
  def slide_move!(end_pos)
    board[end_pos] = self
    board.set_to_empty(self.pos)
    self.pos = end_pos
  end

  def jump_move(end_pos)
    if valid_jump_moves.include?(end_pos)
      jump_move!(end_pos)
      true
    else
      false
    end
  end
  # private?
  def jump_move!(end_pos)
    jmp_diff   = [ end_pos[0] - self.pos[0], end_pos[1] - self.pos[1] ]
    jmp_diff   = [ jmp_diff[0]/2, jmp_diff[1]/2 ]
    jumped_pos = [ self.pos[0] + jmp_diff[0], self.pos[1] + jmp_diff[1]]

    #debugger
    board.set_to_empty(jumped_pos)
    board[end_pos] = self
    board.set_to_empty(self.pos)
    self.pos = end_pos

  end

  def dup(new_board)
    self.class.new(new_board, pos, color, king?)
  end

  def valid_moves
    valid_moves = valid_jump_moves
    if valid_moves.count < 1
      valid_moves.concat(valid_slide_moves)
    end
    valid_moves
  end

  def valid_jump_moves
    valid_moves = []

    #debugger

    move_diffs.each do |diff|

      #check jumped pos and color
      jumped_pos = [ self.pos[0] + diff[0], self.pos[1] + diff[1] ]
      unless board.occupied?(jumped_pos) &&
             board[jumped_pos].color != self.color
        next
      end
      #
      jmp_diff = [ diff[0]*2, diff[1]*2 ]
      end_pos = [ self.pos[0] + jmp_diff[0], self.pos[1] + jmp_diff[1] ]
      if board.on_board?(end_pos)  &&
         !board.occupied?(end_pos)
         valid_moves << end_pos
      end
    end

    valid_moves
  end

  def valid_slide_moves
    valid_moves = []

    return valid_moves if valid_jump_moves.count > 0

    move_diffs.each do |diff|
      end_pos = [ self.pos[0] + diff[0], self.pos[1] + diff[1] ]
      if board.on_board?(end_pos) &&
         !board.occupied?(end_pos)
         valid_moves << end_pos
       end
    end

    valid_moves
  end

  def move_diffs
    return_diffs = []

    down_diffs = [
      [1,  1],
      [1, -1]
    ]

    up_diffs = [
      [-1,  1],
      [-1, -1]
    ]

    if self.king?
      return_diffs.concat(down_diffs)
      return_diffs.concat(up_diffs)
    else
      if self.color == Board::COLOR1
        return_diffs.concat(down_diffs)
      else
        return_diffs.concat(up_diffs)
      end
    end

    return_diffs
  end

end
