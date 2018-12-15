Dir["./funcs/*.rb"].each { |file| require file}
Dir["./lib/*.rb"].each { |file| require file}

class Tester
  def initialize
  end

  def call
    # Run each alg from k = 1 to k = 10 for performance comparison
    # Run each for 60 seconds and compare how many solutions were found
    # most basic thing is run them head to head and get how long it took to run

    k = 8
    result = FindNarcs.new.call(k, "Standard")
    fast_result = FastFindNarcs.new.call(k, "Fast")

    holder = ResultHolder.new("Test Run")

    holder.add_result(result)
    holder.add_result(fast_result)

    holder.print_results
    holder.print_chart
  end
end