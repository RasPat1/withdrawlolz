require './Node.rb'
require './CelebGenerator.rb'
require './CelebAPI.rb'

# Celebrity Problem
# Within a given population of N individuals a celebrity existsi if
# there is an individual who does not konw any one else in the population
# AND is konwn by everyone else in thepopulation
# Given a constant time query to determine if an individual konws another
# determine an efficient way of finding thecelebriry if one exists


# Return null if no celebrity exists otherwise return the celebrity
class Celebs
  attr_accessor :ca, :cb

  def initialize(size, ca)
    @ca = ca
  end

  def call
    stack = []
    @ca.nodes.each do |node|
      stack << node
    end

    da_celeb = nil

    while stack.size > 0
      if stack.size == 1
        if is_celeb(stack[0])
          da_celeb = stack[0]
        end
        break
      end

      # stack must be at least 2 here
      node1 = stack.pop
      node2 = stack.pop

      # if n1 knows n2 => n1 is not a celeb, n2 may be a celeb
      # if n2 knows n1 => n2 is not a celeb, n1 may be a celeb
      # if neither of them know each other => neither are celebs
      # if they both konw each other => neither are celebs

      one_knows_two = @ca.query(node1, node2)
      two_knows_one = @ca.query(node2, node1)

      if one_knows_two && !two_knows_one
        stack << node2
      elsif two_knows_one && !one_knows_two
        stack << node1
      end
    end

    da_celeb
  end

  def is_celeb(celeb_node)
    @ca.nodes.each do |node|
      next if node == celeb_node
      return false if @ca.query(celeb_node, node)
    end
    @ca.nodes.each do |node|
      next if node == celeb_node
      return false if !@ca.query(node, celeb_node)
    end

    true
  end
end