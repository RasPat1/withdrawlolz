# There are n students sitting in a circle
# Each student cheats off of someone to there left or right
# what is the expected number of students that will
# not have anyone cheating off of them
class Cheaters
  def call(n, times = 1000000)
    count = 0
    not_cheated_off_count = 0

    while count < times
      students = []

      # All students are cheating to thier left or right
      n.times do |index|
        students[index] = rand <= 0.5 ? 'L' : 'R'
      end

      # puts students.inspect

      students.each_with_index do |student, index|
        left_s = students[index - 1]
        right_s = students[(index + 1) % (students.size)]
        # puts "Index: #{index} left_s: #{left_s}, right_s: #{right_s}"

        if left_s == 'L' && right_s == 'R'
          not_cheated_off_count += 1
        end
      end

      count += 1
    end

    not_cheated_off_count.to_f / count.to_f
  end
end

puts Cheaters.new.call(8)