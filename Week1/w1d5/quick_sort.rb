def quick_sort(arr)
  return arr if arr.length == 1
  arr.shuffle!
  pivot = arr.shift

  left = []
  right = []

  arr.each_with_index do |num, idx|
    
    left << num if num < pivot
    right << num if num > pivot
  end

  quick_sort(left) + [pivot] + quick_sort(right)

end

p quick_sort([5,4,3,6,7,89,3,2])
