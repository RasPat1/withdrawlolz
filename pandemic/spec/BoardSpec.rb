require '../lib/Board.rb'
require './SpecBase.rb'

class BoardSpec < SpecBase
  def test
    assert Board.new != nil, "Init Board"
  end
end
