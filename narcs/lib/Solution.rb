class Solution
  attr_accessor :value, :elapsed_time

  def initialize(value, elapsed_time)
    @value = value
    @elapsed_time = elapsed_time
  end

  def to_s
    "#{value}: #{(elapsed_time * 1000).truncate(2)}ms"
  end
end