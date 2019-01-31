# Actions that a player can do
class Action
  attr_accessor :type

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

  def self.can_take_action(player, type)
    case type
    when CURE
      return player.location.infections > 0
      # return true
    # when FLY
    #   @player.has_city_card(player.location)
    # when
    when TRAVEL
      # player.location.neighbors.size > 0
      return true
    end

    false
  end
end