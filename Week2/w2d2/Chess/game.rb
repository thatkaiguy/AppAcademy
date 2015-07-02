require_relative 'board'
require_relative 'human_player'
require_relative 'pieces'
require_relative 'invalid_move_error'
require 'byebug'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [HumanPlayer.new("Player1", :blue),
                HumanPlayer.new("Player2", :red)]
    players.rotate!
    @cursor = [0,0]
    board.cursor_pos = cursor_pos
  end

  def cursor_pos
    @cursor.dup
  end

  def play
    until game_over?
      # puts "game over? #{game_over?}"
      display_board
      play_turn
      switch_sides
    end
    display_board
    game_over_message
  end

  def display_board
    board.render
  end

  def current_player
    players.first
  end

  def play_turn
    puts "#{current_player.color} is in check!" if player_in_check?
    move_made = false
    until move_made
      move_made = make_move
    end
  end

  def make_move
    start_pos = select_moving_piece
    display_board
    end_pos = select_target_piece
    if board.danger_zone?(start_pos, end_pos)
      puts "This move will put you in check."
      puts "Please select different moves"
      false
    else
      board.move!(start_pos, end_pos)
      true
    end
  end

  def switch_sides
    board.selected_pos = nil
    players.rotate!
  end

  def player_in_check?
    board.in_check?(current_player.color)
  end

  def select_moving_piece
    begin
      print "#{current_player.color}, select starting position."
      start_pos = get_position_from_cursor

      if board.valid_starting_piece?(start_pos) && board.color(*start_pos) == current_player.color
        board.selected_pos = start_pos
      elsif board.color(*start_pos) != current_player.color
        raise InvalidMoveError.new("You do not control this piece.")
      end
    rescue InvalidMoveError => error
      puts error.message
      retry
    end
    start_pos
  end

  def select_target_piece
    begin
      print "#{current_player.color}, select target position."
      end_pos = get_position_from_cursor
      board.valid_target?(end_pos)
    rescue InvalidMoveError => error
      puts error.message
      retry
    end
    end_pos
  end

  def get_position_from_cursor
    input = nil
    until input == :enter
      input = parse_input(current_player.get_position)
      board.cursor_pos = input
      display_board
    end
    cursor_pos
  end

  def parse_input(key_pressed)
    case key_pressed.downcase
    when "w"
      @cursor[0] -= 1 if board.on_board?(@cursor[0] - 1, @cursor[1])
    when "a"
      @cursor[1] -= 1 if board.on_board?(@cursor[0], @cursor[1] - 1)
    when "s"
      @cursor[0] += 1 if board.on_board?(@cursor[0] + 1, @cursor[1])
    when "d"
      @cursor[1] += 1 if board.on_board?(@cursor[0], @cursor[1] + 1)
    when "\r"
      return :enter
    when "\e"
      puts "GOODBYE"
      exit
    end
    cursor_pos
  end

  def game_over?
    players.each do |player|
      if board.checkmate?(player.color)
        return true
      end
    end
    false
  end

  def game_over_message
    puts "Checkmate!"
    puts "#{players.last.color} wins!"
  end
end

g = Game.new.play
