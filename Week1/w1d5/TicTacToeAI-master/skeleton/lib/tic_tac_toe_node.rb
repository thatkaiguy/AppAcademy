require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_accessor :next_mover_mark, :board, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #debugger
    if @board.over? && (@board.winner == evaluator || @board.winner.nil?)
      return false
    elsif @board.over?
      return true
    end

    if evaluator == @next_mover_mark # This is for the player making the next move
      self.children.all? do |kid|
        kid.losing_node?(evaluator)
      end
    else # This is for the opponent making the next move
      self.children.any? do |kid|
        kid.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over? && @board.winner == evaluator
      return true
    elsif @board.over?
      return false
    end

    if evaluator == @next_mover_mark # This is for the player making the next move
      self.children.any? do |kid|
        kid.winning_node?(evaluator)
      end
    else
      self.children.all? do |kid|
        kid.winning_node?(evaluator)
      end
    end
  end

  def next_mark(current_mark)
    if current_mark == :x
      return :o
    else
      return :x
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        children << pos if @board.empty?(pos)
      end
    end

    children.map! do |child|
      new_board = @board.dup
      new_board[child] = @next_mover_mark
      TicTacToeNode.new( new_board, next_mark(@next_mover_mark), child )
    end
    children
  end
end
