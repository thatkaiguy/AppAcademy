class Game
TITLE = "GHOST"
  def initialize(players_ct)
    @players = []
    players_ct.times do |ct|
      @players << Player.from_name
    end
    @losses = Hash.new(0)
    @fragment = ""
    dictionary = {}
    File.readlines("ghost-dictionary.txt").each do |word|
      word = word.chomp
      dictionary[word] = word
    end
    @dictionary = dictionary
  end

  def valid_play?(string)
    word_found = false
    return false if string.length != 1

    new_fragment = @fragment + string
    @dictionary.values.each do |word|
        word_found = true if new_fragment == word[0...new_fragment.length]
    end
    word_found
  end

  def round_over?
    @dictionary.has_key?(@fragment)
  end

  def play_round
    @fragment = ""
    until round_over?
      guess = nil
      until (guess && valid_play?(guess))
        guess = current_player.guess
        current_player.alert_invalid_guess unless valid_play?(guess)
      end
      @fragment << guess
      puts "The current fragment is: #{@fragment}"
      next_player!
    end
    puts "#{previous_player} has been eliminated!"
    @players.pop
    #@losses[previous_player] += 1
  end

  def run
    until @players.length == 1
      play_round
      display_standings
    end
    puts "#{current_player} wins!"
    # if @losses[current_player] == 5
    #   puts "#{previous_player} wins!"
    # else
    #   puts "#{current_player} wins!"
    # end
  end

  def display_standings
    puts "Current players are:"
    @players.each do |player|
      puts "#{player}"
    end
    # if @losses[current_player] > 0
    #   puts "#{current_player}: #{TITLE.slice(0, @losses[current_player])}"
    # end
    # if @losses[previous_player] > 0
    #   puts "#{previous_player}: #{TITLE.slice(0, @losses[previous_player])}"
    # end
  end


  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players.rotate!
  end

  # def aardvark
  #   p @dictionary
  #   puts @dictionary["aardvark"]
  #
  #   puts @dictionary.has_key?("aardvark")
  #
  # end

end

class Player
  def self.from_name
    puts "Please enter a name:"
    name = gets.chomp
    Player.new(name)
  end
  def initialize(name)
    @name = name
  end
  def guess
    puts
    print "#{@name}, add a letter: "
    input = gets.chomp
  end
  def alert_invalid_guess
      print "#{@name}, invalid guess! Enter another: "
  end
  def to_s
    @name
  end
end

game = Game.new(4)
game.run
