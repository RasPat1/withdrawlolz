class FastestFindNarcs
  def initialize
  end

  def call(max_k, result_name, max_seconds=nil)
    start_time = Time.now
    result = Result.new(result_name)
    digits = (0..9).to_a

    1.upto(max_k) do |k|
      powers = (0..9).map { |i| i ** k }

      low_limit = 10 ** (k-1)
      upper_limit = 10 ** k

      digits.repeated_combination(k) do |combo|
        break if max_seconds != nil && (Time.now - start_time).to_i > max_seconds
        sum = combo_to_sum(combo, powers)
        next if (sum < low_limit || sum >= upper_limit) && k != 1

        if narc?(sum, combo)
          result.add_solution(sum, Time.now)
        end
      end
    end

    result
  end

  def combo_to_sum(combo, powers)
    combo.map { |digit| powers[digit] }.sum
  end

  def narc?(sum, combo)
    sum.digits.sort == combo.sort
  end
end