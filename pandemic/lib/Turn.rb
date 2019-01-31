# Each players turn
class Turn
  attr_accessor :player, :actions

  MAX_ACTIONS = 4

  def initialize(player, actions = [])
    @player = player
    @actions = actions
  end

  def act(type_index)
    puts "Acting"
    if type_index > Action::ACTION_TYPES.size
      return false
      # Todo: Make some set of custom exceptions
      raise Exception.new
    end
    action = Action::ACTION_TYPES[type_index]

    case action
    when Action::CURE
      @player.location.remove_infection
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