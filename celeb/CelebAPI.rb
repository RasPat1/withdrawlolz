require './Node.rb'
require './CelebGenerator.rb'

class CelebAPI
  attr_accessor :nodes
  def initialize(nodes)
    @nodes = nodes
  end

  def query(a, b)
    a.outgoing.include?(b)
  end
end

