class Turn
  attr_acccessor :player, :actions

  MAX_ACTIONS = 4

  def initialize(player, actions = [])
    @player = player
    @actions = actions
  end

  def act(type)
    return false if @actions.size >= 4
    @actions << Action.new(act_type)
  end

end

# Actions that a player can do
class Action
  attr_acccessor :type

  ACTION_TYPES = [
    CURE = :cure,
    SHARE = :share,
    RESEARCH = :research,
    BUILD = :build,

    # city next to you
    # reserach station to reserach station
    # Use card to go from current city to card city
    # Use card to go from card city to any city
    TRAVEL = :travel
  ]

  def initialize(type)
    @type = type
  end
end