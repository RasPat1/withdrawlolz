require './Node.rb'
require './CelebGenerator.rb'
require './CelebAPI.rb'

class DoesItWork
end

n = Node.new
n2 = Node.new
n.add_incoming(n2)
n2.add_incoming(n)
n.add_outgoing(n2)

raise Exception.new unless n == n
raise Exception.new unless n2 == n2
raise Exception.new unless n != n2
raise Exception.new unless n.outgoing.size == 1
raise Exception.new unless n2.outgoing.size == 1
raise Exception.new unless n.incoming.size == 1
raise Exception.new unless n2.incoming.size == 1

# puts n
# puts n2

Node.reset
cb = CelebGenerator.new(1, 0.2)
cb.call(5)
cb.nodes.each do |node|
  raise Exception.new unless node.outgoing.size == node.outgoing.uniq.size
  raise Exception.new unless node.incoming.size == node.incoming.uniq.size
end
puts cb

ca = CelebAPI.new(cb.nodes)
puts ca.query(cb.nodes[0], cb.nodes[1])
puts ca.query(cb.nodes[1], cb.nodes[0])
puts ca.query(cb.nodes[1], cb.nodes[1])
puts ca.query(cb.nodes[2], cb.nodes[3])
puts ca.query(cb.nodes[3], cb.nodes[4])
