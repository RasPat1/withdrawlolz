class WeightedIntervalScheduling
  attr_accessor :interval_list

  def initialize(interval_list)
    @interval_list  = interval_list
  end


  # Find optimal schedule using dynamic programming
  # At each point in time we want to have found the optimal value to that point
  # and then select whther to include or not include the next interval
  def schedule(start = 0, stop = 100)

    # Sort intervals by end point asc
    # iterate from left to right
    # at each endpoint find the max weight from the start to that endpoint
    # Make a comparison if the start of the interval is after the end of the previous "checkpoint"
    # add the weight adn that is the new checkpoint
    # if it overlaps then select the larger of the two endpoints
    # This is almost right but not quite
    # we want to break up at previously weighed sectionif we need to
    # we shodul get keep the list of all endpoints weights

    # x---x
    #       x----x
    #          x-------x

    # 1,4,3
    # 5,9,4
    # 7,12,5

    # Keep the checkpoints here
    # [4:3, 9:7]
    # then see 7,12,5
    # choose 5 or 7 we'd say 7 and may want to do say 7 is max from 0<=>12
    # but if we split it up
    # [4:3, 9:7, 12:8]
    # we could get max 8 if we exclude the middle one

    endpoints = []
    interval_list = sort(@interval_list)

    interval_list.each do |interval|
      max_weight = interval.weight
      steps = []

      # endpoint list is sorted so ya konw we could just do binary search here
      # woudl bring the whoel thing down to nlgn
      endpoints.reverse.each do |endpoint|
        if interval.start > endpoint.stop
          max_weight += endpoint.best_weight
          steps = endpoint.steps.clone
          break
        end
      end

      # If we do better by ignoring this interval than record that
      if endpoints.last && endpoints.last.best_weight > max_weight
        max_weight = endpoints.last.best_weight
        steps = endpoints.last.steps
      else
        steps << interval
      end

      endpoints << EndpointWeight.new(interval.stop, max_weight, steps)
    end

    # endpoints is non-decrasing with each entry. Last must be max
    puts endpoints.last
    endpoints.last.best_weight
  end

  # Insertiion Sort
  def sort(list)
    result = []
    list.each do |interval|
      inserted = false

      result.each_with_index do |sorted_interval, index|
        if interval.stop < sorted_interval.stop
          result.insert(index, interval)
          inserted = true
          break
        end
      end

      if !inserted
        result << interval
      end

    end

    result
  end

end

class WeightedInterval
  attr_accessor :start, :stop, :weight
  def initialize(start, stop, weight)
    @start = start
    @stop = stop
    @weight = weight
  end

  def to_s
    "(#{start}<=>#{stop}):#{weight}"
  end
end

class EndpointWeight
  attr_accessor :stop, :best_weight, :steps
  def initialize(stop, best_weight, steps)
    @stop = stop
    @best_weight = best_weight
    @steps = steps
  end

  def to_s
    "[#{steps.join(',')}]=>#{stop}:#{best_weight}"
  end
end

class Tester
  def test
    t1 = []
    t1 << WeightedInterval.new(1,3,1)
    t1 << WeightedInterval.new(4,6,1)
    t1 << WeightedInterval.new(2,4,3)
    run(t1)


    t2 = []
    t2 << WeightedInterval.new(1,3,2)
    t2 << WeightedInterval.new(4,6,2)
    t2 << WeightedInterval.new(2,4,1)
    run(t2)

    # Optimal here is 8
    t3 = []
    t3 << WeightedInterval.new(1,4,3)
    t3 << WeightedInterval.new(5,9,4)
    t3 << WeightedInterval.new(7,12,5)
    run(t3)

    # Optimal here is 8
    t4 = []
    t4 << WeightedInterval.new(1,4,3)
    t4 << WeightedInterval.new(3,9,4)
    t4 << WeightedInterval.new(8,12,5)
    run(t4)

    # Optimal here is 9
    t5 = []
    t5 << WeightedInterval.new(1,4,3)
    t5 << WeightedInterval.new(3,9,4)
    t5 << WeightedInterval.new(10,12,5)
    run(t5)

    # Optimal here is 7
    t6 = []
    t6 << WeightedInterval.new(1,4,3)
    t6 << WeightedInterval.new(5,9,4)
    t6 << WeightedInterval.new(2,12,5)
    run(t6)

    # Optimal here is 10
    t7 = []
    t7 << WeightedInterval.new(1,4,3)
    t7 << WeightedInterval.new(3,9,4)
    t7 << WeightedInterval.new(2,12,10)
    run(t7)

    # Optimal here is 12
    t7 = []
    t7 << WeightedInterval.new(1,4,3)
    t7 << WeightedInterval.new(5,9,4)
    t7 << WeightedInterval.new(10,12,5)
    run(t7)

    # Optimal here is 10
    t8 = []
    t8 << WeightedInterval.new(1,4,3)
    t8 << WeightedInterval.new(2,3,5)
    t8 << WeightedInterval.new(10,12,5)
    run(t8)

    # Optimal here is 11
    t9 = []
    t9 << WeightedInterval.new(1,4,6)
    t9 << WeightedInterval.new(2,3,3)
    t9 << WeightedInterval.new(10,12,5)
    run(t9)
  end

  def run(list)
    result = WeightedIntervalScheduling.new(list).schedule
    puts "Max Weight: #{result}"
  end
end

Tester.new.test