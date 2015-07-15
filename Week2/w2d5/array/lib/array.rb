class Array

  def my_uniq
    result = []
    self.each do |el|
     result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []

    self.each_with_index do |first_num, i|
      break if i == length - 1
      self[i + 1 ..-1].each_with_index do |second_num, j|

        result << [i, j + i + 1] if first_num + second_num == 0

      end
    end

    result
  end

  def median
    sorted = self.sort
    mid = count/2

    if count.even?
      return (sorted[mid - 1] + sorted[mid]) / 2.0
    else
      return sorted[mid]
    end
  end

  def my_transpose
    result = Array.new(count) { Array.new(self.first.count) }

    self.each_with_index do |row, i|
      row.each_with_index do |num, j|
        result[j][i] = num
      end
    end

    result
  end
end
