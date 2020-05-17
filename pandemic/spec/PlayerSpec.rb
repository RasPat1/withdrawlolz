require './lib/Player.rb'
require './spec/SpecBase.rb'

class PlayerSpec < SpecBase
  def test
    test_init
    test_name
  end

  def test_init
    assert Player.new("Test Player") != nil, "Init Player"
  end

  def test_name
    name = "T1"
    p1 = Player.new(name)
    assert p1.name == name
  end
end