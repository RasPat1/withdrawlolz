# Find the count of elements shared between 2 sorted arrays
class CommonElementCount
  def call(a1, a2)
   puts nsq(a1, a2)
   puts nlogn(a1, a2)
   puts nwnspace(a1, a2)
   nwconstantspace(a1, a2)
  end

  def nsq(a1, a2)
    count = 0
    iterations = 0

    a1.each do |val1|
      a2.each do |val2|
        count += 1 if val1 == val2
        iterations += 1
      end
    end

    puts "N Squared Solution\nIterations: #{iterations}"
    count
  end

  def nlogn(a1, a2)
    count = 0
    iterations = 0

    a1.each do |val1|
      success, bin_iterations = bin_search(val1, a2)
      count += 1 if success
      iterations += bin_iterations
    end

    puts "N Log N Solution\n Iterations: #{iterations}"
    count
  end

  def bin_search(val, arr)
    low = 0
    high = arr.size - 1
    mid = low + high / 2
    iterations = 0
    success = false

    while low <= high && low >= 0 && high < arr.size
      iterations += 1

      if val == arr[mid]
        success = true
        break
      elsif val < arr[mid]
        high = mid - 1
      else
        low = mid + 1
      end

      mid = (low + high) / 2

    end

    return success, iterations
  end

 def nwnspace(a1, a2)
  count = 0
  iterations = 0

  a2map = {}
  a2.each do |val|
    a2map[val] = true
  end
  a1.each do |val|
    count += 1 if a2map.key?(val)
    iterations += 1
  end

  puts "O(N) time and O(N) space Solution\n Iterations: #{iterations}"
  count
 end

 def nwconstantspace(arr_1, arr_2)
  count = 0
  iterations = 0

  pointer_1 = 0
  pointer_2 = 0
  while pointer_1 < arr_1.size && pointer_2 < arr_2.size
    value_1 = arr_1[pointer_1]
    value_2 = arr_2[pointer_2]

    if value_1 == value_2
      count += 1
      pointer_1 += 1
      pointer_2 += 1
    elsif value_1 < value_2
      pointer_1 += 1
    else
      pointer_2 += 1
    end

    iterations += 1
  end

  puts "O(N) time and O(1) space Solution\n Iterations: #{iterations}"
  count
 end

end

class RandomUniqueSortedArrayGenerator
  def call(size)
    max = size * 8
    arr = []

    size.times do |time|
      begin
        num = rand_num(max)
      end while arr.index(num) != nil

      arr << num
    end

    arr.sort
  end

  def rand_num(max)
    (rand * max).floor
  end
end
size = 1000
a1 = RandomUniqueSortedArrayGenerator.new.call(size)
a2 = RandomUniqueSortedArrayGenerator.new.call(size)
puts a1.join(', ')
puts a2.join(', ')

puts CommonElementCount.new.call(a1, a2)