require_relative 'tile'
require 'byebug'

class Board
  BOMB_COUNT = 6
  attr_reader :accumulated_time
  
  def initialize
    @grid = Array.new(9) { Array.new(9) }
    self.seed_board
    self.generate_tiles
    @accumulated_time = 0
  end

  def set_accumulated_time
    @accumulated_time += time_from_start
  end

  def time_from_start
    Time.now.to_i - @start_time
  end

  def reset_timer
    @start_time = Time.now.to_i
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def seed_board
    BOMB_COUNT.times do |bomb|
      valid_bomb = false
      until valid_bomb
        b_pos = [rand(9), rand(9)]
        valid_bomb = self[b_pos].nil?
      end
      self[b_pos] = :b
    end
  end

  def generate_tiles
    @grid.map!.with_index do |row, row_idx|
      row.map!.with_index do |space, col_idx|
        Tile.new(self, !space.nil?, [row_idx, col_idx])
      end
    end
  end

  def solved?
    flag_ct = 0

    grid.flatten.each do |tile|
      if (tile.bomb? && !tile.flagged?)
        return false
      elsif tile.flagged?
        flag_ct += 1
        return false if flag_ct > BOMB_COUNT
      end
    end

    true
  end

  def flag(pos)
    self[pos].toggle_flag
  end

  def reveal(pos)
    self[pos].reveal
  end

  def render
    grid.each do |row|
      puts row.join(" ")
    end
    puts "____________________"
  end

  private

    attr_reader :grid
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new

  b.render
end
