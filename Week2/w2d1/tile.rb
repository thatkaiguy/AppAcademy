require 'colorize'

class Tile
  attr_reader :board, :bomb
  attr_accessor :revealed

  def initialize(board, bomb, pos)
    @board = board
    @bomb = bomb
    @revealed = false
    @flagged = false
    @pos = pos
  end

  def neighbors
    row, col = @pos
    neighbors = [
      [row, col + 1],
      [row, col - 1],
      [row + 1, col],
      [row - 1, col],
      [row + 1, col + 1],
      [row + 1, col - 1],
      [row - 1, col - 1],
      [row - 1, col + 1]
    ]
    neighbors.select { |neighbor| neighbor.all?{ |n| n.between?(0,8) } }
  end

  def neighbor_bomb_count
    self.neighbors.select { |pos| board[pos].bomb }.count
  end

  def bomb?
    bomb
  end

  def flagged?
    @flagged
  end

  def toggle_flag
    @flagged = flagged? ? false : true
  end

  def revealed?
    revealed
  end

  def reveal
    return nil if bomb?
    self.revealed = true

    if self.neighbor_bomb_count == 0
      to_reveal = []
      fringe = []
      neighbors.each do |pos|
        tile = board[pos]
        if !tile.revealed? && !tile.bomb? && !tile.flagged?
          if tile.neighbor_bomb_count == 0
            to_reveal << tile
          else
            fringe << tile

          end
        end
      end

      fringe.each { |fringe_tile| fringe_tile.revealed = true }
      to_reveal.each { |tile| tile.reveal }
    end
    true
  end

  def to_s
    if revealed?
      if self.neighbor_bomb_count == 0
        "_"
      else
        color_code(self.neighbor_bomb_count.to_s)
      end
    elsif flagged?
      color_code("F")
    elsif bomb?
      "B"
    else
      "*"
    end
  end

  def color_code(string)
    case string
    when "1"
      string.colorize(:color => :blue)
    when "2"
      string.colorize(:color => :green)
    when "F"
      string.colorize(:color => :light_blue)
    else
      string.colorize(:color => :red)
    end
  end

end
