class FasterFindNarcs
  def initialize
  end

  def call(max_k, result_name, max_seconds=nil)
    start_time = Time.now
    result = Result.new(result_name)
    powers = [1] * 10
    sums = {{} => 0}
    maxSoFar = 0

    1.upto(max_k) do |k|
      break if max_seconds != nil && (Time.now - start_time).to_i > max_seconds
      new_sums = {}
      count = 0
      interval_time = 0
      puts "k: #{k}"
      puts "Starting Sum Size: #{sums.size}"

      powers = powers.map.with_index(0) {|value, index| value * index }
      sums.each do |digit_combo, sum|
        break if max_seconds != nil && (Time.now - start_time).to_i > max_seconds

        powers.each_with_index do |power, index|
          count += 1
          digit_clone = digit_combo.clone
          digit_clone = add_to_map(index, digit_clone)

          if !new_sums.key?(digit_clone)
            new_sum = sum_digits(digit_clone, k) # O(k)
            new_sum_size = new_sum.to_s.size

            if new_sum_size > k
              break
            elsif new_sum_size < k
              next
            elsif new_sum_size == k
              new_sums[digit_clone] = new_sum

              if n_narc?(digit_clone, new_sum, k)
                result.add_solution(new_sum, Time.now)
              end
            end
          end

        end
      end

      sums = new_sums
      puts "Iterations for this k: #{count}"
    end

    result
  end

  def add_to_map(index, map)
    if map.key?(index)
      map[index] += 1
    else
      map[index] = 1
    end

    map
  end

  # check if they have the same characters
  def n_narc?(digit_combo, sum, k)
    new_combo = {}

    sum.digits.each do |digit|
      add_to_map(digit, new_combo)
    end

    digit_combo == new_combo
  end

  def sum_digits(digit_combo, k)
    sum = 0

    digit_combo.each do |key, count|
      sum += (key ** k) * count
    end

    sum
  end
end


#### NOTES #####
# What are some useful data struvtures and potential math tricks we can use to speed this up
  # Essentailly we are trying to iterate up to a 10^60 which is lol since 10^80 is like particles
  # in the observable universe
  # So we can safely say that the iterating and checking a number will never be efficient enough
  # If we can exclude some portion of values that woudl be great! But we'd have to add the rules while generating the
  # bounds of our loop to make sure we skip enough of the values per actual loop iteration to make a difference
  # So we know visiting each number is too slow
  # We know skipping ranges of numbers that are not valid will save us time if we have rules that can scale as
  # k scales. In other words, removing 1/2 of the values for each k still leads us to too many iterations
  # Approaching the opposite way maybe we have rules that can generate all possible numbers
  # Let's try to most obvious rule and see if we make some progress
  # Let's say for some value of k we take the sum of all the kth powers of 0-9 and add all combinations of k
  # of them together
  # Once getting these values we know the digits (in a random order) and the sum
  # if that sum contains the same digits and the same frequencies than we know that the sum is a valid narc
  # Does this save us time and if so how much?
  # Let's assume we do some amount of work that scales with k on each combination of digits. We'll have to check if
  # sum of the powers is a permutation of the digits used to generate that combo. We can use a couple techniques here
  # and i think we can get it down to at least O(k*lg k) without any analysis
  # in that case lets count how many iterations we'll do with this strategy
  # We're choosing k values out of 10 digits with replacement (multichoose) this may be really nice becasue we know
  # that the 10 stays fixed. Perhaps we're onto something here
  # MC(n, k) = B(n + k - 1, k) where MC is multichoose and B is Binomial coefficient
  # In our case n = 10 and k = the number of digits in the number
  # Looks good so far how does this scale compared to goign through each number
  # aka MC(n,k) / (10^k) or rather whats the rate of growth of the top chunk
  # B(n, k) = n! / (k! * (n-k)!) so if n = n + k - 1
  # MC(n,k) = (n + k - 1)!/(k! * (n-1)!)
  # Pluggin this into wolfram alpha using n = 10 and taking a look at the ratio of
  # the possible number of combinations and the 10^k full space we get the right growth behavior. This should tame
  # the iteration count problem
  # Example looks like k = 50 leads to 12.5B values That's not all that bad
  # To get a full solution here we'd want the sum from k = 1 to k = 60 of the MC
  # and that looks like 400 Billion. That is not out of the realm of possibility!
  # We happen to know that that last value is at k = 39 so that totals 8.2 Billion possibilities
  # and we can probably reach at least that far on this laptop in 60 seconds
  # Maybe we can get clever about some rules to stop certain groups of permutations
  # We may be able to build our possible sums quickly by using the previous list of sums

  # Rough Alg:
  # Initi
  # Generate inital powers of digits 0-9
  # Generate initial sums of all combinations of 0-9 aka 0-9 and associate with the digits that were used to get the sum
  # yay they're all solutions
  # Increase k
  # update powers
  # Double iteration through digits and sums
  # This generates a new set of all possible sums
  # We have to be very careful here. Duplicate sums can be generated via different combinations of
  # digits. We can't de dupe here. But in the process of generating all the combinations we will
  # have duplicate sets of digits (which will also have the same sums). These can be deduped
  # Example, the digit sets (1,2) and (2,3) are different. But in teh updating k iteration we
  # may add 3 to the first set and 1 to the second set giving us duplicate sets
  # It seems liek we can iterate in a specific way to avoid this? Let's hold off on that for now
  # Just use a hash map where the combination of digits used in generation is the key
  # we can probably right this as a recursive alg and use dynamic programming here


# Okay! We did that and now we went from 27 to 41 solutions in 60 seconds. A huge improvement.
# We see k getting up to 13 with the faster version. THe older versions only made it up to 8 or 9 i believe
# Let's try add another trick to reduce iterations.  We're still very far from k = 60
# I'm going to call this approach converge from the top. There are some digit combos that have a sum that
# is very low. Too low to even have a sum w/ k digits. We keep these values in our map of maps because
# there may still be solutions down the road that "catch-up". HOWEVER! When they do catch up the digit combo
# will be reached by many paths. Instead of waiting till we get the collision and then marking a successful
# value let's remove all the digit combos who have sums that are so low the only solutions they can lead to can be
# converged to from a digit combo which currently has a higher sum
# Let's say our heuritic is remove all digit combos that lead to a sum that has less than k digits
# I feel this is safe but haven't proven it yet. Let's give it a simple whirl and see what happens
# So it looked like we went from 41 to 42! solutions and k made it to 14. Let's look for bigger ideas

# We have really 2 growth rates we want to look at
# As k increases how does the number of iterations increase
# As k increases how does the work per iteration change
# The # of iterations does not appear to be increasing exponentially as the rate of increase is slowing over time
# The work per iteration seems to be linear in k

# Can we use tries or prefix trees here to solve the "convergence issue" and avoid any work that leads
# to checking duplicate combos downstream

# Maybe if we use a differnt type of data structure to represent the combos and iterate through
# all possible combos so we hit each one only once
# THis may not be a reasonable solution since we are not sure our current rate of duplication
# Also we know that the whole thing is growing non-polynomially anyways right? How far cna you really
# get with that
