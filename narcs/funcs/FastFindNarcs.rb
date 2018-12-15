class FastFindNarcs
  def initialize
  end

  def call(k, result_name)
    result = Result.new(result_name)
    max = 10 ** k
    powers = {}
    current_k = 0

    0.upto(max - 1) do |n|
      sum = 0
      num_digits = n.to_s.size
      original_n = n

      if num_digits > current_k
        current_k = num_digits
        10.times do |digit|
          powers[digit] = digit ** current_k
        end
      end

      str = n.to_s
      str.each_char do |char|
        sum += powers[char.to_i]
      end

      if sum == original_n
        result.add_solution(original_n, Time.now)
      end
    end

    result
  end
end

#### NOTES #####
# What are some useful data struvtures and potential math tricks we can use to speed this up
  # What if!
    # for each group of numbers with k digits we start by precomputing 1 through 9 to the kth power
    # then do a hash look up for each number rather than gaving to do the math
    # this would be useful if the kth power calculation is much slower than a hash lookup (it prob is)
    # Also, the range of possible values are from (1) to (k * 9^k)
    # low bound 1 followed by all 0's 100 = 1^3 + 0^3 + 0^3 = 1
    # upper bound all 9's 999 = 9^3 + 9^3 + 9^3 = k * 9^k
    # we want to overlap between that and 10 ^ (k - 1) and (10 ^ k) - 1 aka 100 - 999 for k = 3
    # for k = 3 we could ay our ranges are 1 - 2187 and 100 - 999 so we'd get 100 - 999
    # for k = 8 ranges are 1 - 344373768 and 100000000 - 99999999
    # This is a bad approach, it looks like the ranges become distinct with no overlap at k = 60
    # No narcs with k >= 60
    # The 10 ^ (k -1) to (10 ^ k) - 1 range is the one we'll use each time
    # What if we generate in reverse. Rather than iterating over each number
    # Find the numbers in each range that can be created using a selection of kth powers
    # Get the 9 values associated with 1^k, 2^k, 9^k etc...
    # Then select all k length combinations (order doesn't matter) and find any values that are
    # in the range
    # Check if their is a permuation of the digits that create that number?

    # Fast find Procedure
    # for k < 5? use regular find_narcs
    # compute all kth powers of the digits 1 - 9
    # For each combination of the digits 1 - 9 of length k compute the sum
    # If that sum is out of the range skip it
    # if that sum in the range check if the sum uses teh same digits that it was generated from
