# Actions that a player can do
class Action
  attr_accessor :type

  ACTION_TYPES = [
    CURE = :cure,
    SHARE = :share,
    RESEARCH = :research,
    BUILD = :build,

    # city next to you
    DRIVE = :drive,
    # Discard a City card to move to the city named on the card.
    DIRECT_FLIGHT = :direct_flight,
    # Discard the City card that matches the city you are in to move to any city.
    CHARTER_FLIGHT = :charter_flight,
    # Move from a city with a research station to any other city that has a research station.
    SHUTTLE_FLIGHT = :shuttle_flight
  ]

  def initialize(type)
    @type = type
  end

  def self.can_take_action(player, type)
    case type
    when CURE
      player.location.infections > 0
      # return true
    # when FLY
    #   @player.has_cit y_card(player.location)
    # when
    when DRIVE
      true
    when DIRECT_FLIGHT
      player.hand.size > 0
    when CHARTER_FLIGHT
      player.hand.map { |card| card.city }.include?(player.location)
    when SHUTTLE_FLIGHT
      # ToDo: Implement research stations
      false
    else
      false
    end
  end
end