# Each players turn
class Turn
  attr_accessor :player, :actions

  MAX_ACTIONS = 4

  def initialize(player, actions = [])
    @player = player
    @actions = actions
  end

  def act(type)
    return false if @actions.size >= 4
    @actions << Action.new(act_type)
  end

  def show_actions
    Action::ACTION_TYPES.each_with_index do |action, index|
      if Action.can_take_action(player, action)
        puts "#{index}) Player can #{action}"
      end
    end
  end
end