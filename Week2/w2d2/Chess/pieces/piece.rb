require 'colorize'

class Piece
  attr_accessor :pos
  attr_reader :color, :board

  def initialize(board, pos, color = nil)
    @board = board
    @color = color
    @pos = pos
  end

  def empty?
    false
  end

  def dup(new_board)
    self.class.new(new_board, pos.dup, color)
  end
end
