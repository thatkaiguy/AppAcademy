require 'set'

class Keypad
  attr_reader :key_presses, :mode_keys
  
  def initialize(code_length = 4, mode_keys = [1,2,3])
    @code_bank = []
    @code_length = code_length
    @mode_keys = mode_keys
    @key_presses = 0
    clear
  end

  def clear
    @code_bank = Array.new(10**@code_length,0)
    @key_history = []
    @key_presses = 0
  end

  def press(number)
    @key_history.shift while @key_history.size > @code_length
    @key_history.push(number)
    @key_presses += 1
    #puts number
    #sleep (0.1)
    check_code
  end

  def check_code
    if @mode_keys.include?(@key_history.last) && @key_history.length > @code_length
      #puts @code_bank[@key_history[0,@code_length].join.to_i]
      @code_bank[@key_history[0,@code_length].join.to_i] += 1
    end
  end

  def all_codes_entered?
    #puts "#{@code_bank.count { |x| x>0 }} entries banked"
    #sleep(0.01)
    not @code_bank.include?(0)
  end

  def unentered_code
    puts "#{@code_bank.index(0)}"
  end

  def key_history
    @key_history
  end

end
