require_relative 'piece'
require_relative 'empty_square'
require 'colorize'

class Board

  COLOR1 = :black
  COLOR2 = :red
  EMPTYSQUARE = EmptySquare.new


  def self.get_checkers_board
    checkers_board = Board.new

    #place black pieces on top
    (0..2).each do |row_idx|
      checkers_board.size.times do |col_idx|
        curr_pos = [row_idx, col_idx]
        new_piece = Piece.new(checkers_board, curr_pos, COLOR1, false)
        #place on dark squares
        if row_idx != 1 && col_idx % 2 != 0
          checkers_board[curr_pos] = new_piece
        elsif row_idx == 1 && col_idx % 2 == 0
          checkers_board[curr_pos] = new_piece
        end
      end
    end

    #place white pieces on bottom
    (5..7).each do |row_idx|
      checkers_board.size.times do |col_idx|
        curr_pos = [row_idx, col_idx]
        new_piece = Piece.new(checkers_board, curr_pos, COLOR2, false)
        #place on dark squares
        if row_idx != 6 && col_idx % 2 == 0
          checkers_board[curr_pos] = new_piece
        elsif row_idx == 6 && col_idx % 2 != 0
          checkers_board[curr_pos] = new_piece
        end
      end
    end

    #for testing!! TODO remove these pieces!
    # red_piece = Piece.new(checkers_board, [3,2], COLOR2, false)
    # black_piece = Piece.new(checkers_board, [2,1], COLOR1, false)
    # checkers_board[[3,2]] = red_piece
    # checkers_board[[2,1]] = black_piece

    checkers_board
  end

  def initialize
    @grid = Array.new(8) { Array.new(8) { EMPTYSQUARE } }
  end

  def on_board?(pos)
    row, col = pos
    row >= 0 && row < self.size && col >= 0 && col < self.size
  end

  def occupied?(pos)
    on_board?(pos) && !self[pos].empty?
  end

  def set_to_empty(pos)
    self[pos] = EMPTYSQUARE
  end

  def size
    #assumes square grid
    grid.size
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def render
    background_colors = [:light_white, :light_black]

    grid.each do |row|
      row.each do |square|
        curr_color = background_colors.first
        print square.render.colorize(:background => curr_color)
        background_colors.rotate!
      end
      background_colors.rotate!
      puts
    end
  end

  # def jump(start_pos, *other_positions)
  #   piece = self[start_pos]
  #   # TODO change to non bang version
  #   piece.jump_move!(other_positions.first)
  # end
  #
  # def slide(start_pos, end_pos)
  #   #TODO: change to call slide_move (non bang)
  #   piece = self[start_pos]
  #   piece.slide_move!(end_pos)
  #
  # end

  def wins?(color)
    other_pieces = all_pieces_of(other_color(color))
    other_pieces.count == 0 || other_pieces.none? {|pc| pc.valid_moves.size > 0}
  end

  def other_color(color)
    color == COLOR1 ? COLOR2 : COLOR1
  end

  def all_pieces_of(color)
    grid.flatten.select { |piece| piece.color == color }
  end

  def dup
    new_board = self.class.new

    8.times do |row_idx|
      8.times do |col_idx|

        pos = [row_idx, col_idx]
        square = self[pos]

        if square.empty?
          new_board[pos] = EMPTYSQUARE
        else
          new_board[pos] = square.dup(new_board)
        end

      end
    end

    new_board
  end

  private

  attr_reader :grid

end



if __FILE__ == $PROGRAM_NAME
  # testing
  b = Board.get_checkers_board
  b.render
  puts

  p b[[0,1]].valid_slide_moves
  p b[[2,7]].valid_slide_moves
  puts
  p b[[2,1]].valid_slide_moves
  p b[[2,1]].valid_jump_moves
  #b.slide([2, 1], [3, 0])
  sleep(2)
  b.jump([2,1], [4,3])
  b.render

end
