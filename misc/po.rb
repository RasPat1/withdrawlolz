def jobOffers(scores, lower_limits, upper_limits)
  raise StandardError if lower_limits.size != upper_limits.size
  raise StandardError if scores.size == 0 || scores.size == nil

  result = []
  # ensure scores are sorted for binary search
  scores = scores.sort

  lower_limits.each_with_index do |lower_limit, index|
    upper_limit = upper_limits[index]

    count = count_scores_in_range(scores, lower_limit, upper_limit)
    result << count

  end

  result
end

# Determine number of valid candidates with scores in range
def count_scores_in_range(scores, lower_limit, upper_limit)
  # Since we are looking for integers use 0.5 less than lower limit and 0.5 more
  # than upper limit to get first and last index of limit
  lower_limit_index = binary_search(scores, lower_limit - 0.5, 0, scores.size)
  upper_limit_index = binary_search(scores, upper_limit + 0.5, 0, scores.size)

  # if we're at the last index we don't need to add one
  if upper_limit_index == scores.size
    upper_limit_index = upper_limit_index - 1
  end

  upper_limit_index - lower_limit_index
end

def binary_search(scores, target, left_index, right_index)
  mid_index = (left_index + right_index) / 2
  value = scores[mid_index]

  if left_index >= mid_index
    left_index
  elsif value == target
    mid_index
  elsif value < target
    binary_search(scores, target, mid_index, right_index)
  elsif value > target
    binary_search(scores, target, left_index, mid_index)
  end
end
