class Card
  attr_reader :value, :show
  attr_accessor :paired

  def initialize(value)
    @show = false
    @paired = false
    @value = value
  end

  def ==(other_card)
    @value == other_card.value
  end

  def to_s
    @value.to_s
  end

  def reveal
    @show = true
  end

  def hide
    @show = false
  end

end

class Board
  attr_accessor :grid
  attr_reader :size

  def initialize(board_size)
    @grid = Array.new(board_size) { Array.new(board_size) }
    @size = board_size**2
  end

  def populate
    number_of_pairs = (@grid.count * @grid.first.count) / 2
    number_of_pairs.times do |pair_number|
      card = Card.new(pair_number)

      2.times do |time|
        pos = get_random_position

        while !is_empty(*pos)
          pos = get_random_position
        end

        @grid[pos.first][pos.last] = card.dup
      end
    end

  end

  def render
    @grid.each do |row|
      display_row = []

      row.each do |card|
        if card.show
          display_row << card.to_s
        else
          display_row << " "
        end
      end

      puts display_row.join("|")
    end

  end

  def won?
    @grid.each do |row|
      row.each do |card|
        return false if !card.show
      end
    end
    true
  end

  def reveal(row, col)
    @grid[row][col].reveal
  end

  def get_random_position
    [rand(@grid.count), rand(@grid.count)]
  end

  def is_empty(row, col)
    @grid[row][col].nil?
  end

  def get_card(row,col)
    @grid[row][col]
  end

end

class HumanPlayer
  def get_pos
    puts "Please enter in position:"
    gets.chomp.split(",").map! { |position| position.to_i }
  end

  def add_guess(row, col, card_value)
  end
end

class AIPlayer
  @previous_guesses = {}
  def get_pos
    puts "Please enter in position:"
    gets.chomp.split(",").map! { |position| position.to_i }
  end
  def add_guess(row, col, card_value)
    @previous_guesses[[row,col]] = card_value
  end
end

class Game

  def initialize(difficulty, player_type)
    @board = Board.new(difficulty)
    @moves = @board.size
    #@player_type = player_type
    @player = HumanPlayer.new
  end
  '''
  def play_human_game

  end

  def play_ai_game

  end
  '''
  def play
    @board.populate
    '''
    if @player_type = "human"
      play_human_game
    elsif @player_type = "ai"
      play_ai_game
    end
    '''
    while !@board.won? && @moves > 0
      @board.render
      @player.play_turn
      @previous_guess = self.current_guess
      play_turn

      @board.render
      sleep(1)
      system("clear")
      check_cards
      @moves -= 1
      puts "You have #{@moves} left"

    end
    if @moves <= 0
      puts "You lost!"
    else
      puts "Congrats you won!"
    end
  end

  def check_cards
    card1 = @board.get_card(*@previous_guess)
    card2 = @board.get_card(*@current_guess)
    if card1 != card2
      card1.hide if !card1.paired
      card2.hide if !card2.paired
    else
      card1.paired = true
      card2.paired = true
    end
  end

  def current_guess
    @current_guess
  end

  def play_turn
    pos = @player.get_pos
    while !is_valid_pos(*pos)
        puts "Position invalid."
        pos = @player.get_pos
    end
    make_guess(*pos)
  end

  def is_valid_pos(row, col)
    row < @board.grid.count && col < @board.grid.count
  end

  def make_guess(row, col)
    @board.reveal(row, col)
    @current_guess = [row, col]
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Please choose difficulty level (2 to 10)."
  difficulty = gets.chomp.to_i
    while difficulty < 2 || difficulty > 10
      puts "Please choose difficulty level (1 to 10)."
      difficulty = gets.chomp.to_i
    end
  game = Game.new(difficulty, "sdf")
  game.play
end
