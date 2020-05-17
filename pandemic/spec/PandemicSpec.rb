require './lib/Pandemic.rb'
require './spec/SpecBase.rb'

class PandemicSpec < SpecBase
  def test
    test_init

  end

  def test_init
    assert Pandemic.new != nil, "Init Game"
  end

  def test_play
    game = Pandemin.new
    # Game started w/ 1 player
    puts game
    game.turn
  end
end