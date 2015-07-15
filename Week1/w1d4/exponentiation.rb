require 'byebug'

def range(start, ends)
  #debugger
  return [start] if start == ends
  old_ranges = range(start, ends - 1)
  new_num = old_ranges.last + 1
  old_ranges << new_num
  #ranges << range(start, ends-1).last + 1
  #ranges
end

#p range(1,5)

def exp(base, value)
  return 1 if value == 0
  base * exp(base,value - 1)
end

def exp2(base, value)
  return 1 if value == 0
  num = exp2(base,value/2)
  value.even? ? num*num :  base * exp2(base,(value - 1)/2)**2
end


# puts exp(10,5)
# puts exp2(10,5)
# puts exp2(10,1)


  def deep_dup(array)
    return array if !array.is_a?(Array)
    array.map do |x|
      deep_dup(x)
    end
  end


def fibonacci(n)
  return [1] if n == 1
  return [1]*n if n == 2
  fib_numbers = fibonacci(n - 1)
  fib_numbers << fib_numbers.last + fib_numbers[-2]
end

def binarysearch(array, target)
  #debugger
  return nil if array.empty?
  mid_index = array.length/2
  if array[mid_index] > target
    index = binarysearch(array[0...mid_index],target)
    return index == nil ? nil : index
  elsif array[mid_index] == target
    return mid_index
  else
    index = binarysearch(array[mid_index + 1..-1],target)
    if index
      return index + mid_index + 1
    else
      return nil
    end
  end
end


def make_change(value,change)
  #best_set = []
  return [value] if change.include? value
  best_sets = []
  change.each_with_index do |num, idx|
    if value - num >= 0
      this_change = change[idx..-1]
      best_sets << [num] + make_change(value-num, this_change)
    end
  end

  best_sets.sort_by {|ary| ary.length }[0]
end

def merge_sort(array)
  return array if array.size == 1
  left = merge_sort(array[0...array.length/2])
  right = merge_sort(array[array.length/2..-1])
  merge(left, right)
end

def merge(left, right)
  #x, y = 0 ,0
  arr = []
  #debugger
  # while(x < left.length && y < right.length)
  #   if(left[x] >= right[y])
  #     arr << right[y]
  #     y += 1
  #   else
  #     arr << left[x]
  #     x += 1
  #   end
  # end
  # arr += left[x..-1] += right[y..-1]

  until left.empty? || right.empty?
    if left.first >= right.first
      arr << right.shift
    else
      arr << left.shift
    end
  end

  arr += left.empty? ? right : left

end


#p make_change(14,[10,7,1])

p merge_sort([0,6,3,8,32,21,8])
#p binarysearch([0,1,2,3,4,5],5)


def subsets(array)
  return [array] if array.empty?
  old_subsets = subsets(array[0..-2])
  new_subsets = old_subsets.map do |subset|
                   subset.dup << array.last
                end
  old_subsets + new_subsets
end

#p subsets([1,2,3])
