require './Node.rb'
require './CelebGenerator.rb'
require './CelebAPI.rb'
require './Celebs.rb'
require './Solution.rb'
require './Graph.rb'


solutions = []
graph_gen = []

60.times do |size|
  node_count = size
  gen_start = Time.now
  cb = CelebGenerator.new
  cb.call(size)
  ca = CelebAPI.new(cb.nodes)
  gen_finish = Time.now

  start = Time.now
  Celebs.new(node_count, ca).call
  finish = Time.now
  solutions << Solution.new(node_count, finish - start)
end

graph = Graph.new(solutions)
graph.print_chart