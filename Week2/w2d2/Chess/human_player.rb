require 'io/console'

class HumanPlayer
  attr_reader :name, :color

  def initialize(name = "Player1", color)
    @name = name
    @color = color
  end

  def get_position
    pos = $stdin.getch
  end

end
