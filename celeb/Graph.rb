require 'gruff'
require './Solution.rb'

class Graph
  attr_accessor :solutions
  def initialize(solutions)
    @solutions = solutions
  end

  def print_chart
    g = Gruff::Line.new

    g.title = 'Celebs'
    g.y_axis_label = "Time (s)"
    g.x_axis_label = "Node Count"
    g.hide_dots = true

    labels = {}
    1.upto(60) do |val|
      if val % 3 == 1
        labels[val] = val.to_s
      end
    end

    g.labels = labels
    count = 0

    xy_coords = solutions.map do |solution|
      [
        solution.size,
        solution.elapsed_time
      ]
    end

    linear_coords = []
    solutions.length.times do |val|
      linear_coords << [val, val.fdiv(4000)]
    end

    puts xy_coords
    g.dataxy("Runs", xy_coords)
    g.dataxy("compare", linear_coords)
    g.write('celeb_perf.jpg')
  end
end