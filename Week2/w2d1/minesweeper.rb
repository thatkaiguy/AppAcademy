require_relative 'board'
require 'yaml'

class MineSweeper

  def run
    get_board
    puts "Enter 's' before any turn to save and quit."
    board.reset_timer
    @bomb_hit = false
    input = nil

    until game_won? || bomb_hit?
      input = get_input
      if input == "s"
        board.set_accumulated_time
        save_game
        break
      elsif valid_input?(input)
        take_turn(input)
        system("clear")
        board.render
      end
    end

    unless input == "s"
      if game_won?
        print_congrats
        board.set_accumulated_time
        update_leaderboard
        #display_total_time_played
      else
        print_bomb
      end
        #(game_won? ? print_congrats : print_bomb)
    end
    display_total_time_played

  end

  def update_leaderboard
    stats = File.readlines("leaderboard.txt").map { |stat| stat.chomp.to_i }
    stats << board.accumulated_time

    File.open("leaderboard.txt", 'w') do |f|
      stats.sort[0..9].each do |stat|
        f.puts stat
      end
    end
  end

  def display_total_time_played
    puts "#{board.accumulated_time} seconds"
  end

  def valid_input?(input)
    action, row, col = input.split(",")
    if [action, row, col].any? { |inp| inp.nil? }            ||
       [row, col].any? { |x| !(x =~ /[0-8]/) }               ||
       ["f", "r"].none? { |char| char == action.downcase }
       false
     else
       true
    end
  end

  def get_board
    puts "Would you like to (l)oad or start a (n)ew game?"
    case gets.chomp.downcase
    when "l"
      @board = YAML.load_file('state.yml')
    when "n"
      @board = Board.new
    end
    board.render
  end


  def print_congrats
    system("clear")
    puts "Congrats you've won!"
  end

  def print_bomb
    system("clear")
    puts "BOOM"
  end

  def save_game
    File.open('state.yml', 'w') { |f| f.puts @board.to_yaml }
  end

  def get_input
    puts "(F)lag or (R)eveal? and position. (eg. R, 4, 2)"
    gets.chomp
  end

  def take_turn(input)
    action, row, col = input.split(",")

    if action.downcase == "f"
      board.flag([row.to_i, col.to_i])
    elsif action.downcase == "r"
      reveal = board.reveal([row.to_i, col.to_i])
      @bomb_hit = true if reveal.nil?
    end
  end

  def bomb_hit?
    @bomb_hit
  end

  def game_won?
    board.solved?
  end


  private
    attr_reader :board, :bomb_hit

end

if __FILE__ == $PROGRAM_NAME
  m = MineSweeper.new
  m.run
end
