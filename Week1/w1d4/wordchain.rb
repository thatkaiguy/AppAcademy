require 'set'
require 'byebug'

class WordChainer
  attr_reader :dictionary
  attr_accessor :all_seen_words, :current_words

  def initialize
    @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
  end

  def adjacent_words(word)
    adj_words = []
    word.length.times do |i|
      ('a'..'z').each do |test_letter|
        test_word = word.dup
        test_word[i] = test_letter
        next if test_word == word
        adj_words << test_word if @dictionary.include?(test_word)
      end
    end
      adj_words
    # adj_words = []

    # @dictionary.each do |dict_word|
    #   next if dict_word == word
    #   adj_words << dict_word if is_adjacent?(dict_word,word)
    # end
    # adj_words
  end

  def is_adjacent?(dict_word,actual_word)
    count = 0
    return false if dict_word.length != actual_word.length
    dict_word.chars.each_with_index do |letter,idx|
      if letter != actual_word[idx]
        count += 1
      end
      return false if count == 2
    end
    true
  end

  def run(source)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty?
      @current_words = explore_current_words
    end

  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
       adjacent_words(word).each do |adj_word|
        unless all_seen_words.include?(adj_word)
          new_current_words << adj_word
          all_seen_words[adj_word] = word
        end
       end
    end
    new_current_words.each {|w| puts "new word: #{w} source: #{@all_seen_words}"}
    new_current_words
  end

  def build_path(target)
    #puts "go in here"
    source_found = false
    path = []
    until source_found
      #debugger
      value = @all_seen_words[target]
      target = value
      value ? path << value : source_found = true
    end
    path
  end

end

wc = WordChainer.new
wc.run("sticker")
p wc.build_path("slander")
