# Each players turn
class Turn
  attr_accessor :player, :actions

  MAX_ACTIONS = 4

  def initialize(player, city_deck, board, actions = [], io = NoOpIO.new)
    @player = player
    @city_deck = city_deck
    @actions = actions
    @board = board
    @io = io
  end

  def act(type_index)
    if type_index > Action::ACTION_TYPES.size || type_index < 0
      return false
      # Todo: Make some set of custom exceptions
      raise Exception.new
    end

    action = Action::ACTION_TYPES[type_index]

    case action


    when Action::CURE
      @player.location.remove_infection


    when Action::DRIVE
      current_city = @player.location

      # ToDo: woof really breaking separation of concerns here
      # ToDo: Remove this to some prompting element
      @io.puts "Which city are you going to?"
      current_city.neighbors.each_with_index do |city, index|
        @io.puts "#{index}) #{city.name}"
      end

      destination_index = @io.gets
      new_city = current_city.neighbors[destination_index.to_i]
      @player.move(new_city) unless new_city == nil


    when Action::DIRECT_FLIGHT
      @io.puts "Which city are you going to? This will discard that cities card"
      @player.hand.each_with_index do |card, index|
        @io.puts "#{index}) #{card.city.name}"
      end

      card_index = @io.gets
      destination = @player.hand.delete_at(card_index.to_i)
      @player.location = destination.city
      @city_deck.discard(destination)


    when Action::CHARTER_FLIGHT
      card_index = @player.hand.map { |card| card.city }.index(@player.location)
      card = @player.hand.delete_at(card_index)
      @city_deck.discard(card)

      @io.puts "Which city are you going to? (#{card.city} discarded)"
      city_list = []
      @board.cities.each do |city_name, city|
        @io.puts "#{city_list.size}) #{city_name}"
        city_list << city
      end

      city_index = @io.gets
      @player.location = city_list[city_index.to_i]


    when Action::SHUTTLE_FLIGHT
    end

    @actions << action
  end

  def show_actions
    Action::ACTION_TYPES.each_with_index do |action, index|
      if Action.can_take_action(player, action)
        @io.puts "#{index}) Player can #{action}"
      end
    end
  end
end
