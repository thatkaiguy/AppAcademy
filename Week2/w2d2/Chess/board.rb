require_relative 'pieces'

class Board
  attr_reader :empty_space, :color1, :color2
  attr_accessor :grid, :selected_pos, :cursor_pos

  def deep_dup
    new_board = Board.new(false)
    empty_space = EmptySpace.new

    8.times do |row|
      8.times do |col|
        tile = self[row, col]
        if tile.empty?
          new_board[row, col] = empty_space
        else
          new_board[row,col] = tile.dup(new_board)
        end
      end
    end
    new_board
  end

  def initialize(do_placement = true)
    @empty_space = EmptySpace.new
    @grid = Array.new(8) { Array.new(8) { empty_space } }
    @color1 = :blue
    @color2 = :red
    @selected_pos = nil
    place_pieces if do_placement
  end

  def [](row,col)
    grid[row][col]
  end

  def []=(row,col,value)
    grid[row][col] = value
  end

  def place_pieces
    # [Rook, Knight].each |class|
    # class.new
    8.times do |col|
      self[1,col] = Pawn.new(self, [1,col], color1)
      self[6,col] = Pawn.new(self, [6,col], color2)
    end
    #place rooks
    self[0,0] = Rook.new(self, [0,0], color1)
    self[0,7] = Rook.new(self, [0,7], color1)
    self[7,0] = Rook.new(self, [7,0], color2)
    self[7,7] = Rook.new(self, [7,7], color2)
    #place knights
    self[0,1] = Knight.new(self, [0,1], color1)
    self[0,6] = Knight.new(self, [0,6], color1)
    self[7,1] = Knight.new(self, [7,1], color2)
    self[7,6] = Knight.new(self, [7,6], color2)
    #place bishops
    self[0,2] = Bishop.new(self, [0,2], color1)
    self[0,5] = Bishop.new(self, [0,5], color1)
    self[7,2] = Bishop.new(self, [7,2], color2)
    self[7,5] = Bishop.new(self, [7,5], color2)
    #place royalty
    self[0,3] = Queen.new(self, [0,3], color1)
    self[0,4] = King.new(self, [0,4], color1)
    self[7,3] = Queen.new(self, [7,3], color2)
    self[7,4] = King.new(self, [7,4], color2)
  end

  def render(selected = nil)
    system("clear")
    background_colors = [:light_black, :light_white]
    highlights = highlighted_positions

    grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        background_color = background_colors.rotate!.first
        background_color = :light_green if [row_idx, col_idx] == selected_pos
        background_color = :yellow if highlights.include? [row_idx,col_idx]
        background_color = :green if [row_idx, col_idx] == cursor_pos
        print el.symbolize.colorize(:background => background_color)
      end
      background_colors.rotate!
      puts
    end
  end

  def highlighted_positions
    # debugger
    return [] unless selected_pos
    self[*selected_pos].valid_moves
  end

  def on_board?(row, col)
    row.between?(0,7) && col.between?(0,7)
  end

  def occupied?(row, col)
    !self[row, col].empty?
  end

  def color(row, col)
    self[row, col].color
  end

  def move!(start_pos, end_pos)
    self[*end_pos] = self[*start_pos]
    self[*end_pos].pos = end_pos
    self[*start_pos] = empty_space
  end

  def valid_starting_piece?(start_pos)
    unless on_board?(*start_pos) && occupied?(*start_pos)
      raise InvalidMoveError.new("Invalid starting piece")
    end
    if self[*start_pos].valid_moves.empty?
      raise InvalidMoveError.new("That piece has no valid moves")
    end
    true
  end

  def valid_target?(end_pos)
    unless on_board?(*end_pos) && highlighted_positions.include?(end_pos)
      raise InvalidMoveError.new("Invalid target piece")
    end
    true
    #board.deep_dup.in_check?(pos)
  end

  #CHECK/CHECKMATE LOGIC

  def other_color(color)
    color == color1 ? color2 : color1
  end

  def pieces_of_color(color)
    grid.flatten.select { |piece| piece.color == color }
  end

  def in_check?(color)
    king = grid.flatten.find { |piece| piece.is_a?(King) && piece.color == color }
    other_pieces = pieces_of_color(other_color(color))

    other_pieces.any? { |piece| piece.valid_moves.include?(king.pos) }
  end

  def checkmate?(color)
    pieces_of_color(color).each do |piece|
      piece.valid_moves.each do |potential_move|
        return false unless self.danger_zone?(piece.pos, potential_move)
      end
    end
    true
  end

  def move(start_pos, end_pos)
    new_board = self.deep_dup
    new_board.move!(start_pos, end_pos)
    new_board
  end

  def danger_zone?(start_pos, end_pos)
    self.move(start_pos, end_pos).in_check?(self[*start_pos].color)
  end
  #
  # private
  # attr_accessor :grid

end
