require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    ttt_node = TicTacToeNode.new(game.board.dup, mark)

    ttt_node.children.each do |kid|
       return kid.prev_move_pos if kid.winning_node?(mark)
    end

    ttt_node.children.each do |kid|
      return kid.prev_move_pos unless kid.losing_node?(mark)
    end

    raise "You are not very smart. You will lose :("

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
