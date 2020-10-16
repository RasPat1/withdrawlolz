require './lib/City.rb'
require './spec/SpecBase.rb'

class CitySpec < SpecBase
  def test
    test_init
    test_edges
    test_edge_adding_edge_conditions
    test_add_infection
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

  def test_add_infection
    c1 = City.new("c1")
    c2 = City.new("c2")
    c3 = City.new("c3")
    c1.add_edge(c2)
    c2.add_edge(c3)

    assert c1.infections == 0
    assert c2.infections == 0
    assert c3.infections == 0

    c1.add_infection
    assert c1.infections == 1
    assert c2.infections == 0
    assert c3.infections == 0

    c1.add_infection(2)
    assert c1.infections == 3
    assert c2.infections == 0
    assert c3.infections == 0

    c2.add_infection
    assert c1.infections == 3
    assert c2.infections == 1
    assert c3.infections == 0

    c1.add_infection
    assert c1.infections == 3
    assert c2.infections == 2
    assert c3.infections == 0

    c1.add_infection
    assert c1.infections == 3
    assert c2.infections == 3
    assert c3.infections == 0

    c0 = City.new("c0")
    c0.add_edge(c1)
    c1.add_infection
    # Todo: Do a rule check here. Is c0 supposed to
    # have 2 infections here. I think so.
    assert c0.infections == 1
    assert c1.infections == 3
    assert c2.infections == 3
    assert c3.infections == 1
  end
end
