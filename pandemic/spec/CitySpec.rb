require './lib/City.rb'
require './spec/SpecBase.rb'

class CitySpec < SpecBase
  def test
    test_init
    test_edges
    test_edge_adding_edge_conditions
  end

  def test_init
    assert City.new("Test City") != nil, "Init City"
  end

  def test_edges
    c1 = City.new("c1")
    c2 = City.new("c2")

    # can add an edge
    c1.add_edge(c2)
    assert c1.neighbors.size == 1
    assert c1.neighbors.include?(c2)

    # edges are 2-way
    assert c2.neighbors.size == 1
    assert c2.neighbors.include?(c1)

    # edges are unqiue
    c1.add_edge(c2)
    assert c1.neighbors.size == 1
    assert c1.neighbors.include?(c2)

    assert c2.neighbors.size == 1
    assert c2.neighbors.include?(c1)

    # edges are unique from both directions
    c2.add_edge(c1)
    assert c1.neighbors.size == 1
    assert c2.neighbors.size == 1
    assert c1.neighbors.include?(c2)
    assert c2.neighbors.include?(c1)
  end

  def test_edge_adding_edge_conditions
    c1 = City.new("C1")
    assert c1.add_edge(nil) == nil
    assert c1.add_edge('asdfadf') == nil

    # If this runs we're happy
    assert true
  end
end