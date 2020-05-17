Dir["./funcs/*.rb"].each { |file| require file}
Dir["./lib/*.rb"].each { |file| require file}

class Tester
  def initialize
  end

    def call
    # Run each alg from k = 1 to k = 10 for performance comparison
    # Run each for 60 seconds and compare how many solutions were found

    k = 40
    max_seconds = 60
    holder = ResultHolder.new("Alt Timed Run Max: #{max_seconds}s")

    funcs = [
      [FindNarcs, k, "Standard", max_seconds],
      [FastFindNarcs, k, "Fast", max_seconds],
      [FasterFindNarcs, k, "Faster", max_seconds],
      [FastestFindNarcs, k, "Fastest", max_seconds],
    ]

    funcs.each do |func_array|
      klass = func_array[0]
      result = klass.new.call(*func_array[1..-1])
      holder.add_result(result)
    end

    holder.print_results
    # holder.print_chart
  end
end