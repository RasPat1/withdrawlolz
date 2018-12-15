class FindNarcs
  def initialize
  end

  def call(k, result_name)
    max = 10 ** k
    result = Result.new(result_name)

    0.upto(max - 1) do |n|
      sum = 0
      num_string = n.to_s
      num_string.each_char do |digit|
        sum += digit.to_i ** num_string.size
      end

      if sum == n
        result.add_solution(n, Time.now)
      end
    end

    result
  end
end