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
    discarded_cards = []

    while @hand.size > MAX_HAND_SIZE
      puts "You have too many cards: Discard a card"
      @hand.each_with_index do |card, index|
        puts "#{index}) #{card.city.name}"
      end
      card_index = gets
      card_index = card_index.to_i
      discarded_cards << @hand[card_index]
      @hand.delete_at(card_index)
    end

    discarded_cards
  end

  def to_s
    "Name: #{@name}
        Location: #{@location}
        Hand: #{Util.show_list(@hand)}"
  end
end
