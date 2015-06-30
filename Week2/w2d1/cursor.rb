require 'io/console'
 
# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!
 
  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!
 
  return input
end
@board = Array.new(9) { Array.new(9, :b) }
def print_board
  print "\033[2J"
  @board.each do |row|
    puts row.join
  end
end
##before do 
##clear screen and move cursor- print "\033[2J"
##print board

print_board
print "\033[0;0H" ## just moves cursor, increment for headers
@cursor_pos = [0, 0]
# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def show_single_key
  c = read_char
 
  case c
  when " "
    puts "SPACE"
  when "\t"
    puts "TAB"
  when "\r"
    puts @cursor_pos
  when "\n"
    puts "LINE FEED"
  when "\e"
    puts "ESCAPE"
  

  when "\e[A"  ##up
    print "\033[1A\033"
    @cursor_pos[1] -= 1
  when "\e[B" ##down
    print "\033[1B\033"
    @cursor_pos[1] += 1
  when "\e[C" ##right
    print "\033[1C\033"
    @cursor_pos[0] += 1
  when "\e[D" ##left
    print "\033[1D\033"
    @cursor_pos[0] -= 1
  

  when "\177"
    puts "BACKSPACE"
  when "\004"
    puts "DELETE"
  when "\e[3~"
    puts "ALTERNATE DELETE"
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when "f"
    puts "flag"
    puts "SINGLE CHAR HIT: #{c.inspect}"
  else
    puts "SOMETHING ELSE: #{c.inspect}"
  end

  #p @cursor_pos
end
 
show_single_key while(true)



=begin
- Position the Cursor:
  \033[<L>;<C>H
     Or
  \033[<L>;<C>f
  puts the cursor at line L and column C.
- Move the cursor up N lines:
  \033[<N>A
- Move the cursor down N lines:
  \033[<N>B
- Move the cursor forward N columns:
  \033[<N>C
- Move the cursor backward N columns:
  \033[<N>D

- Clear the screen, move to (0,0):
  \033[2J
- Erase to end of line:
  \033[K

- Save cursor position:
  \033[s
- Restore cursor position:
  \033[u

=end