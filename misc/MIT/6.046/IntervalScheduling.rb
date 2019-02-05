# Given a set of intervals find the set of non-overlapping intervals w/ maximal size
class IntervalScheduling
  attr_accessor :interval_list

  def initialize(interval_list)
    @interval_list = interval_list
  end

  def schedule(start = 0, stop = 100)
    interval_list = sort(@interval_list)
    results = []

    while interval_list.size > 0
      interval = interval_list.shift

      # None inclusive start/stop times
      if interval.start > start
        start = interval.stop
        results << interval
      end
    end

    results
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

class Interval
  attr_accessor :start, :stop
  def initialize(start, stop)
    @start = start
    @stop = stop
  end

  def to_s
    "(#{start}<=>#{stop})"
  end
end

class Tester
  def test
    intervals = [
      Interval.new(-1,3),
      Interval.new(2,20),
      Interval.new(3,8),
      Interval.new(8,11),
      Interval.new(10,11),
      Interval.new(11,11),
      Interval.new(12,15),
    ]

    result = IntervalScheduling.new(intervals).schedule
    puts "Optimal Intervals: \n#{result.join(",")}"
  end
end

Tester.new.test