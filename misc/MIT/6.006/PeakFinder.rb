# A 1D peak finder
# Given a list of integers return the index of a peak if one exists
# A peak is defined as a value that is greater than or equal to its neighbors
# A value at the start or finidh of a list has at most one neighbor
class PeakFinder
  # Finds a peak in linear time
  # Scans each element checking for a peak
  def findLinear(list)
    list.each_with_index do |value, index|
      left_value = index > 0 ? list[index - 1] : nil
      right_value = index < list.size ? list[index + 1] : nil

      if greater(value, left_value) &&
         greater(value, right_value)
        return [value, index]
      end
    end

    return [nil, -1]
  end

  # Find the peak using binary search
  def findBinary(list, low = 0, high = nil)
    high ||= list.size - 1
    return [list[0], 0] if list.size == 1

    mid_point = (high + low) / 2
    mid_value = list[mid_point]

    # Take card of array edges. Literal boundary conditions
    left_value = mid_point == low ? nil : list[mid_point - 1]
    right_value = mid_point == high ? nil : list[mid_point + 1]

    if greater(mid_value, left_value) && greater(mid_value, right_value)
      return [mid_value, mid_point]
    elsif left_value != nil && left_value >= mid_value
      return findBinary(list, low, mid_point - 1)
    else
      return findBinary(list, mid_point + 1, high)
    end
  end


  # nil safe greater than
  def greater(value, neighbor)
    neighbor == nil || value >= neighbor
  end
end

class Tester
  def test
    tests = [
      [
        [1,2,3,4],
        [[4, 3]]
      ],
      [
        [1,2,3,4,3],
        [[4, 3]]
      ],
      [
        [1,2,3,3],
        [[3, 2], [3,3]]
      ],
      [
        [4,3,2,1],
        [[4,0]]
      ],
      [
        [4,4,2,1],
        [[4,0], [4,1]]
      ]
    ]

    tests.each do |test|
      input = test[0]
      expected = test[1]

      # result = PeakFinder.new.findLinear(input)
      result = PeakFinder.new.findBinary(input)
      if expected.include?(result)
        puts "Test Passed"
      else
        puts "Test Failed! Expected: #{expected.join(',')}, Value: #{value}, Index: #{index}"
      end
    end
  end
end

Tester.new.test