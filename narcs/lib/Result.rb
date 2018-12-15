# This aboject holds metatata about a specific result from our Tester
# Attrs
# Name:
#     This is a way of distinguishing on particular run from another.
#     Include information that helps identify the maxiumu k used or
#     the types of tricks involved in this specific implementation
# Data:
#     A list of the solutions outputed by this run
# Start Time:
#     The time that this run began. This is subssequently used to
#     calculate the elapsed time for each solution produced
class Result
  attr_accessor :name, :data, :start_time
  PAD_CHAR = ' '

  def initialize(name)
    @name = name
    @data = []
    @start_time = Time.now
  end

  def add_solution(value, solve_time)
    elapsed_time = solve_time - start_time
    data << Solution.new(value, elapsed_time)
  end

  def to_s
    largest_value_length = data.map { |s| s.value.to_s.size }.max
    messages = data.map do |s|
      padding = PAD_CHAR * (largest_value_length - s.value.to_s.size)
      display_time = (s.elapsed_time * 1000).truncate(2)
      "#{s.value}#{padding}: #{display_time}"
    end
    messages.join("\n")
  end
end
