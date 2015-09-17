# 1 game object
# 2 player objects
# 5 character types
# 3 of each character
# 15 cards total in each deck
# Starting and getting coins
# Player can do an action, counteraction or challenge

class Game
  @player1
  @player2
  @@turn = 0
  @current_player
  @current_action
  @deck

  def initialize()
    @deck = Deck.new()
    @player1 = Player.new(2, @deck)
    @player2 = Player.new(2, @deck)
    @current_player = @player1

    while true do
      turn()
    end
  end


  # Ask player for action, target (is there action against another player)
  # If no target ask for any player to challenge or counteraction.
    # Enter player number(name), challenge, or character they are counter actioning with
  # If target ask that player if they want to challenge or counteraction
  # Assess success of action, challenge, and/or counteractions
  # Make necessary modifications to player statuses
  # Go to next person's turn
  def turn()
    turn = turn++
    action_id = gets
    target = gets
    @current_action = new Action(action_id, target)

    turn_over = false
    action_failed = false

    @@turn += 1

    puts "#{@current_player} moves: #{@current_action}"

    if (@current_action.can_be_challenged?)
      puts "enter c to challenge"
      challenge = gets
      puts "challenger enter your id"
      player_challenging_id = gets
      if (challenge && player_challenging_id)
        if action.succeeds_on_challenge()
          @player_challenging = get_player_by_id(player_challenging_id)
          @player_challenging.loses_influence()
          @current_player.swap_influence(@current_action)
        else
          @current_player.loses_influence
          action_failed = true
        end
      end
      turn_over = true
    end

    if (!turn_over && @current_action.can_be_countered())
      puts "Enter Y to counteract"
      counteraction = gets
      puts "counteractor enter your id"
      player_counteracting_id = gets

      if counteracting_player_id
        @counteracting_player = get_player_by_id(counteracting_player_id)
        puts "Current player enter Y to challenge this counteraction"
        challenge_counteraction = gets
        if challenge_counteraction
          if @counteracting_player.has_claimed_counteraction_character(@current_action)
            @current_player.loses_influence
            @counteracting_player.swap_influence(@current_action)
          else
            @counteracting_player.loses_influence
          end
          turn_over = true
        else
          turn_over = true
          action_failed = true
        end
      end
    end

    if !action_failed
      @current_action.succeed
    end

    next_player()

    if is_game_over()
      puts "game over"
      puts get_winner
    else
      turn()
    end

  end

  def is_game_over()
    @player1.is_dead || @player2.is_dead
  end

  def get_winner()
    @player1.is_dead ? @player2 : @player1
  end

  def next_player()
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def get_player_by_id(id)
    if id == 1
      @player1
    elsif id == 2
      @player2
    end
  end
end

class Player
  @coin_count
  @influence1
  @influence2

  def initialize(coin_count, deck)
    @coin_count = coin_count
    @influence1 = deck.get_random_influence()
    @influence2 = deck.get_random_influence()
  end

  def is_dead
    !@influence1.active && !@influence2.active
  end
end

class Action
  @action_id
  @target
  @@action_map = {
    "0": {
      description: "Take Income",
      can_be_challenged: false,
      can_be_countered: false
    },
    "1": {
      description: "Take Foreign Aid",
      can_be_challenged: false,
      can_be_countered: true
    },
    "2": {
      description: "Stage a Coup",
      can_be_challenged: false,
      can_be_countered: true
    },
    "3": {
      description: "Take Tax",
      can_be_challenged: true,
      can_be_countered: true
    },
    "4": {
      description: "Assassinate",
      can_be_challenged: true,
      can_be_countered: true
    },
    "5": {
      description: "Exchange",
      can_be_challenged: true,
      can_be_countered: true
    },
    "6": {
      description: "Steal",
      can_be_challenged: true,
      can_be_countered: true
    }
  }

  def initialize(action_id, target)
    @action_id = action_id
    @target = target
  end

  def can_be_challenged?
    @action_map[@action_id].can_be_challenged
  end

  def get_description
    @action_map[@action_id].description
  end

  def to_string
    result = get_description
    if @target > 0
      result +=" on #{@target}"
    end
    result
  end
end

class Deck
  @cards

  # create new deck
  def initialize()
    @cards = []
    @characters = Character.new(0).get_all_characters()
    @characters.each do |character|
      @cards.push(InfluenceCard.new(character)) * 3
    end
  end

  def get_random_influence()
    @cards.shuffle!
    @cards.pop
  end
end

class Character
  @character_id
  @@character_map = {
    "0": {
      name: "Duke",
      action_id: 3
    },
    "1": {
      name: "Assassin",
      action_id: 4
    },
    "2": {
      name: "Ambassador",
      action_id: 6
    },
    "3": {
      name: "Contessa",
      action_id: -1
    },
    "4": {
      name: "Captain",
      action_id: 5
    }
  }

  def initialize(id)
    @character_id = id
  end

  def get_all_characters()
    characters = []
    @@character_map.each_with_index {|character_info, index|
      characters.push(Character.new(index))
    }
    characters
  end
end

class InfluenceCard
  @character
  @active

  def initialize(character)
    @character = character
    @active = true
  end
end
Game.new()