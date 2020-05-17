class Cubes
  def call(max = 1000)
    sums = {}
    count = 0
    distinct_count = 0

    max.times do |num1|
      max.times do |num2|
        next if num1 < num2
        distinct_count += 1
        sum = num1 ** 3 + num2 ** 3
        pair = Pair.new(num1, num2)

        sums[sum] = [] unless sums.key?(sum)
        sums[sum] << pair
      end
    end

    mult_count = 0
    sums.each do |key, value|
      mult_count += 1 if value.size > 2
      value.each do |pair1|
        value.each do |pair2|
          # next if pair1.num1 == pair2.num1 || pair1.num1 == pair2.num2
          next if pair1.num1 <= pair1.num2
          next if pair2.num1 <= pair2.num2
          next if pair1.num1 <= pair2.num1
          # puts "a:#{pair1.num1}, b:#{pair1.num2}, c:#{pair2.num1}, d:#{pair2.num2}"
          count += 1
        end
      end
    end

    puts "SIZE: #{sums.size}"
    puts "pair count: #{max * max}"
    puts "distinct count: #{distinct_count}"
    puts "Diff: #{max * max - sums.size}"
    puts "distinct diff: #{distinct_count - sums.size}"
    puts "Mult Count: #{mult_count}"
    puts "Distinct w/ Mult: #{distinct_count - sums.size + mult_count}"

    count
  end
end

class Pair
  attr_accessor :num1, :num2

  def initialize(num1, num2)
    @num1 = num1
    @num2 = num2
  end
end
puts Cubes.new.call(10000)