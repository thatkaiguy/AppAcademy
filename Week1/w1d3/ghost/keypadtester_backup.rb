require_relative 'keypad'
require 'byebug'

class KeypadTester
  def initialize(length = 4, mode_keys = [1,2,3])
    @keypad = Keypad.new(length, mode_keys)
    @tested_entries = Hash.new(false)
  end

  def run
    entries = ("0000".."9999").to_a
    entries.each do |combo|
      if @tested_entries[combo.to_i]
        puts "skipping #{combo}"
        next
      end
      combo.each_char do |char|
        self.press(char.to_i)
        print char
        self.over?
      end
      #mode = get_mode
      self.press(1)
      print "#{1}"
      puts
      self.over?
    end
    p @keypad.all_codes_entered?
    puts "#{@keypad.key_presses} key_presses"
  end

  def press(number)
    if @keypad.mode_keys.include?(number)
      @tested_entries[@keypad.key_history[-3..-1].join] = true
    end
    @keypad.press(number)
    # if @keypad.all_codes_entered?
    #   p true
    #   puts "#{@keypad.key_presses} key_presses"
    #   return
    # end
  end

  def over?
    if @keypad.all_codes_entered?
      p true
      puts "#{@keypad.key_presses} key_presses"
      puts "#{@tested_entries.length} tested entries"
      return
    end
  end

  def get_mode
    new_code = @keypad.key_history[-3..-1]
    if !@tested_entries[new_code + [3]]
      return 3
    elsif !@tested_entries[new_code + [2]]
      return 2
    else
      return 1
    end
  end

  # def run
  #   entries = ("0000".."10000").to_a
  #   entry_hash = Hash.new(false)
  #   entry_feed = entries.join("")
  #   # print entry_feed
  #   entry_feed.each_char do |char|
  #     #print char
  #     @keypad.press(char.to_i)
  #     if @keypad.all_codes_entered?
  #       p true
  #       puts "#{@keypad.key_presses} keypresses"
  #       return
  #     end
  #   end
  #   @keypad.unentered_code
  # end

end

tester = KeypadTester.new
tester.run
