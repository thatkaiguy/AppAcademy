require_relative 'keypad'
require 'byebug'

class KeypadTester
  def initialize(length = 4, mode_keys = [1,2,3])
    @keypad = Keypad.new(length, mode_keys)
    @tested_entries = Hash.new(false)
    @loops = 0
  end

  def best_code
    out = ""
    pool = make_pool
    best = []
    bestscore = 0
    current_code = nil

    until pool.empty?
      unless current_code
        current_code = pool.sample
        puts "Random code #{current_code}"
      else
        best.clear
        pool.each do |nxt|
          next if nxt == current_code
          if r = (get_suffixes(current_code) & prefixes(nxt)).first
            #byebug
            (best[r.length] ||= []) << nxt
          end
        end
        current_code = (best[bestscore = best.length - 1] || EMPTYARRAY).first
        puts "Found code #{current_code}"

        unless current_code
          bestscore = 0
          bestcode = pool.sample
          puts "Random code #{current_code}"
        end
      end

      pool.delete(current_code)
      # puts "pool count: #{pool.count}"
      merged = current_code[bestscore..-1]
      out << merged
      @loops += 1
    end
    puts out.length
    puts "#{@loops} loops"
    out
  end

  def make_pool
    entries = ("0000".."9999").to_a
    entries.map! do |e|
      e + rand(1..3).to_s
    end
    return entries
  end

  def prefixes(str,max_length = nil)
    get_suffixes(str.reverse,max_length).map do |s|
      s.reverse!
    end
  end

  def get_suffixes(str,max_length = nil)
    start = max_length ? str.length - max_length : 1
    (start..(str.length-1)).map do |i|
      str[i..-1]
    end
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
# tester.run
