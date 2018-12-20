require 'set'

class FastFindNarcs

  def initialize
  end

  # For each k
  # Create a Set of hashes
  # Then go through the hashes and check the sums
  def call(max_k, result_name, max_seconds = nil)
    start_time = Time.now
    result = Result.new(result_name)
    count = 0
    combos = Set.new
    zero = [0] * 10
    zero_hash = zero.hash
    combos.add(zero)

    1.upto(max_k) do |k| # k loops k max is 60
      elapsed_time = (Time.now - start_time).to_i
      break if max_seconds != nil && elapsed_time > max_seconds

      puts "k: #{k}"
      puts "Starting Sum Size: #{combos.size}"

      new_combos = Set.new

      combos.each do |combo_array|
        0.upto(9) do |digit|
          new_combo = combo_array.clone
          new_combo[digit] += 1
          new_combos.add(new_combo)
        end
      end

      new_combos.each do |combo_array|
        sum = 0
        count += 1

        combo_array.each_with_index do |value, index|
          sum += value * (index ** k)
        end

        if narc?(sum, combo_array, zero_hash)
          result.add_solution(sum, Time.now)
        end
      end

      combos = new_combos
      puts "Iterations for this k: #{count}"
    end

    result
  end

  def narc?(sum, combo, zero_hash)
    combo_clone = combo.clone

    sum.digits.each do |digit|
      combo_clone[digit] -= 1
    end

    combo_clone.hash == zero_hash
  end
end