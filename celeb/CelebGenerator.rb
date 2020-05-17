require './Node.rb'

class CelebGenerator
  attr_accessor :nodes

  def initialize(celeb_probability = 0.5, av_connectedness = 0.7, nodes = [])
    @celeb_probability = celeb_probability
    @av_connectedness = av_connectedness
    @nodes = nodes
  end

  def call(size)
    success = false
    tries = 0

    Node.reset
    should_have_celeb = (rand < @celeb_probability)
    celeb_node = should_have_celeb ? rand(size) : -1
    puts "The Celeb Node is: #{celeb_node}"

    generate_nodes(size, celeb_node)
    success = check_celeb_count(@nodes, should_have_celeb)
  end

  def generate_nodes(size, celeb_node)
    size.times do
      @nodes << Node.new
    end

    # max_connectedness = size ** size
    @nodes.each do |from_node|
      @nodes.each do |to_node|
        # no self edges
        next if from_node == to_node

        if from_node == celeb_node
          next
        elsif to_node == celeb_node
          from_node.add_outgoing(to_node)
        end

        if rand < @av_connectedness || from_node.outgoing.size == 0
          from_node.add_outgoing(to_node)
        end
      end
    end
  end

  def check_celeb_count(nodes, should_have_celeb)
    celeb_count = 0

    nodes.each do |node|
      if node.incoming.size == (nodes.size-1) && node.outgoing.size == 0
        celeb_count += 1
      end
    end

    if celeb_count == 1 && should_have_celeb
      true
    elsif celeb_count == 0 && !should_have_celeb
      true
    else
      false
    end
  end

  def to_s
    result = []

    @nodes.each do |node|
      result << node.to_s
    end

    result.join("")
  end
end