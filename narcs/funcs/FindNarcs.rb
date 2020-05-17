class FindNarcs
  def initialize
  end

  def call(k, result_name, max_seconds=nil)
    start_time = Time.now
    max = 10 ** k
    result = Result.new(result_name)

    0.upto(max - 1) do |n|
      break if max_seconds != nil && (Time.now - start_time).to_i > max_seconds
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