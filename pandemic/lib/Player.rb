class Player
  attr_accessor :name, :location, :hand

  MAX_HAND_SIZE = 7

  def initialize(name, location = nil, hand = [])
    @name = name
    @location = location
    @hand = hand
  end

  # fails to move ne location is not connected to old location
  # Updates location and returns true if move is succesful
  def move(new_location)
    # Todo: Throw a custom Exception
    return false unless location.is_connected(new_location)
    @location = new_location

    true
  end

  def add_card(card)
    @hand << card
  end

  def has_city_card(city)
    @hand.each do |card|
      has_card = card.city == city || card.city.name == city.name
      return true if has_card
    end

    false
  end

  def discard_down
    if @hand.size > MAX_HAND_SIZE
      # Ask to Discard? How are we interacting
      # with the user
      # @hand.delete_at(card_index)
      # What's The game interface like
    end
  end

  def to_s
    "#{@name}: #{@location}"
  end
end