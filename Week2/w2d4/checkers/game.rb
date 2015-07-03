require_relative 'board'
require_relative 'human_player'

class Game

  def initialize
    @players = [HumanPlayer.new(Board::COLOR2), HumanPlayer.new(Board::COLOR1)]
    @board = Board.get_checkers_board
    @cursor = [2,1]
    @board.cursor_pos = cursor_pos
  end

  def cursor_pos
    @cursor.dup
  end

  def play
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
    begin
      start_pos = get_cursor_start
      end_positions = get_cursor_end
      piece = board[start_pos]
      if piece.valid_jump_moves.size < 1 &&
         board.all_pieces_of(current_player.color).any? {|pc| pc.valid_jump_moves.size > 0}
         raise InvalidMoveError.new("Another piece has a jump move.")
       end
      piece.perform_moves(*end_positions)
    rescue InvalidMoveError => error
      puts error.message
      retry
    end
  end

  def get_cursor_start
    parsed_input = nil

    until parsed_input                          &&
          parsed_input == "\r"                  &&
          valid_starting_position?(cursor_pos)

      board.cursor_pos = cursor_pos
      display_board
      puts "#{current_player}'s turn!'"

      parsed_input = parse_cursor(current_player.cursor)

    end
    cursor_pos
  end

  def get_cursor_end
    selected_positions = []
    parsed_input = nil

    until parsed_input && parsed_input == "\r"

      board.cursor_pos = cursor_pos
      display_board
      puts "#{current_player} choose an ending position."
      puts "Press Space on a highlighed position to add it the list of selected"
      puts "end positions. "
      puts "Press Enter to end selection."

      parsed_input = parse_cursor(current_player.cursor)
      if parsed_input == " "
        selected_positions << cursor_pos
      end

    end
    selected_positions.uniq
  end

  def parse_cursor(input)
    case input.downcase
    when "w"
      @cursor[0] -= 1 if board.on_board?([@cursor[0] - 1, @cursor[1]])
    when "s"
      @cursor[0] += 1 if board.on_board?([@cursor[0] + 1, @cursor[0]])
    when "d"
      @cursor[1] += 1 if board.on_board?([@cursor[0], @cursor[1] + 1])
    when "a"
      @cursor[1] -= 1 if board.on_board?([@cursor[0], @cursor[1] - 1])
    when "\e"
      raise "You quit!"
      exit
    end
    input
  end

  def valid_starting_position?(pos)
    board.on_board?(pos) &&
    board.occupied?(pos) &&
    board[pos].color == current_player.color &&
    board[pos].valid_moves.count > 0
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
