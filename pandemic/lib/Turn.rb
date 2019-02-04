# Each players turn
class Turn
  attr_accessor :player, :actions

  MAX_ACTIONS = 4

  def initialize(player, city_deck, actions = [])
    @player = player
    @city_deck = city_deck
    @actions = actions
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
      puts "Which city are you going to?"

      current_city.neighbors.each_with_index do |city, index|
        puts "#{index}) #{city.name}"
      end

      destination_index = gets
      new_city = current_city.neighbors[destination_index.to_i]

      @player.move(new_city) unless new_city == nil
    when Action::DIRECT_FLIGHT
      puts "Which city are you going to (This will discard the card)?"
      @player.hand.each_with_index do |card, index|
        puts "#{index}) #{card.city.name}"
      end

      card_index = gets
      destination = @player.hand.delete_at(card_index.to_i)
      @player.location = destination.city
      @city_deck.discard(destination)
    when Action::CHARTER_FLIGHT

    when Action::SHUTTLE_FLIGHT
    end

    @actions << action
  end

  def show_actions
    Action::ACTION_TYPES.each_with_index do |action, index|
      if Action.can_take_action(player, action)
        puts "#{index}) Player can #{action}"
      end
    end
  end
end