def merge_sort(arr)
  return arr if arr.length < 2

  mid_point = arr.count / 2

  left = arr.take(mid_point)
  right = arr.drop(mid_point)

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  merged_arr = []

  if left.first < right.first
      left.each_with_index do |el, l_idx|


  else
    right + left
  end
end
