require_relative 'piece'
require_relative 'empty_square'
require 'colorize'

class Board

  COLOR1 = :black
  COLOR2 = :white


  def self.set_checkers_game
  end

  def initialize
    @empty_square = EmptySquare.new
    @grid = Array.new(8) { Array.new(8) { @empty_square } }
  end

  def render
    background_colors = []
  end

end
