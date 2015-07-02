require_relative 'board'
require_relative 'human_player'

class Game

  def initialize
    @players = [HumanPlayer.new(Board::COLOR2), HumanPlayer.new(Board::COLOR1)]
    @board = nil
    @cursor = [2,1]
  end

  def cursor_pos
    @cursor.dup
  end

  def play
    @board = Board.get_checkers_board
    #debugger
    until board.wins?(current_player.color)
      next_player!
      display_board
      play_turn
    end
    display_board
    puts "#{current_player} wins!"
  end

  def play_turn
    start_pos = get_starting_position
    end_positions = get_end_positions
    begin
      piece = board[start_pos]
      if piece.valid_jump_moves < 1 &&
         all_pieces_of(current_player.color).any? {|pc| pc.valid_jump_moves > 0}
         raise InvalidMoveError.new("Another piece has a jump move.")
       end
      piece.perform_moves(*end_positions)
    rescue InvalidMoveError => error
      puts error.message
    end
  end

  def get_starting_position
    pos = nil
    until pos && valid_starting_position?(pos)
      puts "#{current_player}"
      puts "Please enter a starting position."
      pos = current_player.get_position
    end
    pos
  end

  def valid_starting_position?(pos)
    board.on_board?(pos) &&
    board.occupied?(pos) &&
    board[pos].color == current_player.color &&
    board[pos].valid_moves.count > 0
  end

  def get_end_positions
    input = nil
    end_positions = []
    until !input.nil? && input == "s"
      puts "Please enter in ending positions (eg. 1,2)."
      puts "Enter 's' to stop at any time."

      input = gets.chomp
      end_positions << input.split(",").map(&:to_i)
    end

    ret_val = end_positions[0..-2]
    p ret_val
    ret_val
  end

  def next_player!
    players.rotate!
  end

  def current_player
    players.first
  end

  def display_board
    @board.render
  end

  private
  attr_reader :board, :players

end

if __FILE__ == $PROGRAM_NAME

  checkers = Game.new
  checkers.play

end
