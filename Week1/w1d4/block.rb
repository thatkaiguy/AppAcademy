class Array
  def my_each(&blk)
    #array.my_each{|x| puts x}
    size = self.count
    idx = 0
    while idx < size
      blk.call(self[idx])
      idx += 1
    end

  end

  def my_map(&blk)
    mapped_array = []
    self.my_each do |el|
      mapped_array << blk.call(el)
    end
    mapped_array
  end

  def my_select(&blk)
    select_array = []
    self.my_each do |el|
      select_array << el if blk.call(el)
    end
    select_array

  end

  def my_inject(&blk)

    accum = self.first
    self.drop(1).my_each do |el|
      accum = blk.call(accum, el)
    end
    accum
  end

  def my_sort!(&block)
    sorted = false
    until sorted
      sorted = true
      self.length.times do |x|
        #puts "value is #{block.call(self[x],self[x+1]}"
        if self[x+1] && block.call(self[x], self[x+1]) == 1
          self[x], self[x+1] = self[x+1], self[x]
        #elsif self[x+1] && block.call(self[x],self[x+1]) == -1
          sorted = false
        end
      end

    end
    self
  end

end

def eval_block(*args, &prc)
  raise "NO BLOCK GIVEN" if prc.nil?
  prc.call(*args)
end


eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end


# [0,1,2,3,4].my_each{|x| puts x}
# p [0,1,2,3,4].my_map{|x| x = 3 }
# p [0,1,2,3,4].my_select{|x| x == 3 }
# p [0,1,2,3,4].my_inject{|sum,num| sum + num }
p [2,0,3,1].my_sort!{|num1,num2| num2 <=> num1 }
