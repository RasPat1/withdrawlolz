require '../lib/Pandemic.rb'
require './SpecBase.rb'

class PandemicSpec < SpecBase
  def test
    assert Pandemic.new != nil, "Init Game"
  end
end