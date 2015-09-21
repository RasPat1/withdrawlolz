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

    turn()
  end


  # Ask player for action, target (is there action against another player)
  # If no target ask for any player to challenge or counteraction.
    # Enter player number(name), challenge, or character they are counter actioning with
  # If target ask that player if they want to challenge or counteraction
  # Assess success of action, challenge, and/or counteractions
  # Make necessary modifications to player statuses
  # Go to next person's turn
  def turn()
    puts "Coins: #{@current_player.get_coin_count}"
    @current_player.show_active_cards
    puts Action.show_all_actions.join "\n"
    puts "#{@current_player} what is your action"

    action_id = gets.strip
    current_action = Action.new(action_id)
    if current_action.requires_target
      while target_player && target_player != current_player
        puts "Select a target"
        target_id = gets.strip
        target_player = Player.get_player_by_id(target_id)
      end
      current_action.set_target = target_player
    end

    turn_over = false
    action_failed = false

    @@turn += 1

    puts "#{@current_player} moves: #{current_action}"

    if (current_action.can_be_challenged?)
      puts "Enter Y to challenge"
      challenge = gets.strip
      if challenge == 'Y'
        puts "Challenger enter your id"
        player_challenging_id = gets.strip

        if (challenge && player_challenging_id)
          if @current_player.has_claimed_action_character?(current_action)
            @player_challenging = get_player_by_id(player_challenging_id)
            @player_challenging.loses_influence
            @current_player.swap_influence(current_action, @deck)
          else
            @current_player.loses_influence
            action_failed = true
          end
        end
      end
      turn_over = true
    end

    if (!turn_over && current_action.can_be_countered?)
      puts "Enter Y to counteract"
      counteraction = gets.strip

      if counteraction == 'Y'
        puts "counteractor enter your id"
        counteracting_player_id = gets.strip
        if counteracting_player_id
          @counteracting_player = get_player_by_id(counteracting_player_id)
          puts "Current player enter Y to challenge this counteraction"
          challenge_counteraction = gets.strip
          if challenge_counteraction
            if @counteracting_player.has_claimed_counteraction_character?(current_action)
              @current_player.loses_influence
              @counteracting_player.swap_influence(current_action, @deck)
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
    end

    if !action_failed
      current_action.succeed(@current_player, current_action, @deck)
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
    @player1.is_dead? || @player2.is_dead?
  end

  def get_winner()
    @player1.is_dead? ? @player2 : @player1
  end

  def next_player()
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def get_player_by_id(id)
    if id == "1"
      player = @player1
    elsif id == "2"
      player = @player2
    end
    player
  end
end

class Player
  @id
  @coin_count
  @influence1
  @influence2
  @@id_counter = 1

  def initialize(coin_count, deck)
    @coin_count = coin_count
    @influence1 = deck.get_random_influence
    @influence2 = deck.get_random_influence
    @id = @@id_counter
    @@id_counter += 1
  end

  def set_card(card_num, card)
    if card_num == 1
      @influence1 = card
    elsif card_num == 2
      @influence2 = card
    end
  end

  def is_dead?
    !@influence1.active? && !@influence2.active?
  end

  def has_claimed_counteraction_character?(action)
    @influence1.get_counteraction_id == action.get_id ||
    @influence2.get_counteraction_id == action.get_id
  end

  def has_claimed_action_character?(action)
    @influence1.get_action_id == action.get_id ||
    @influence2.get_action_id == action.get_id
  end

  def swap_influence(action, deck)
    if @influence1.get_action_id == action.get_id
      deck.add_card(@influence1)
      @influence1 = deck.get_random_influence
    elsif @influence2.get_action_id == action.get_id
      @influence1 = deck.get_random_influence
    end
  end

  def loses_influence
    if @influence1.active? && @influence2.active?
      puts "Choose a influence card to reveal. Enter 1 or 2"
      card_to_flip = gets.strip
      if (card_to_flip == "1")
        @influence1.reveal_card
      elsif card_to_flip == "2"
        @influence2.reveal_card
      end
    elsif @influence1.active?
      @influence1.reveal_card
    elsif @influence2.active?
      @influence2.reveal_card
    end
  end

  def add_coin(amount)
    @coin_count += amount
  end

  def get_coin_count
    @coin_count
  end

  def get_active_character_cards
    active_cards = []
    if @influence1.active?
      active_cards.push @influence1
    end

    if @influence1.active?
      active_cards.push @influence2
    end
    active_cards
  end

  def show_active_cards
    if @influence1.active?
      puts @influence1.card_info
    end
    if @influence2.active?
      puts @influence2.card_info
    end
  end

  def get_id
    @id
  end

  def to_s
    "Player #{@id}"
  end
end

class Action
  @action_id
  @target_player
  @@action_map = {
    "0" => {
      :description => "Take Income",
      :can_be_challenged => false,
      :can_be_countered => false,
      :requires_target => false
    },
    "1" => {
      :description => "Take Foreign Aid",
      :can_be_challenged => false,
      :can_be_countered => true,
      :requires_target => false
    },
    "2" => {
      :description => "Stage a Coup",
      :can_be_challenged => false,
      :can_be_countered => false,
      :requires_target => true,
      :prompt => "Who do you want to stage a coup on?"
    },
    "3" => {
      :description => "Take Tax",
      :can_be_challenged => true,
      :can_be_countered => true,
      :requires_target => false
    },
    "4" => {
      :description => "Assassinate",
      :can_be_challenged => true,
      :can_be_countered => true,
      :requires_target => true,
      :prompt => "Who do you want to assasinate?"
    },
    "5" => {
      :description => "Exchange",
      :can_be_challenged => true,
      :can_be_countered => false,
      :requires_target => false,
      :prompt => "Which characters do you want to keep?"
    },
    "6" => {
      :description => "Steal",
      :can_be_challenged => true,
      :can_be_countered => true,
      :requires_target => true,
      :prompt => "Who do you want to steal from?"
    }
  }

  def initialize(action_id)
    @action_id = action_id
  end

  def set_target
    @target_player = target_player
  end

  def can_be_challenged?
    @@action_map[@action_id][:can_be_challenged]
  end

  def can_be_countered?
    @@action_map[@action_id][:can_be_countered]
  end

  def get_description
    @@action_map[@action_id][:description]
  end

  def get_prompt
    prompt = get_character_data[:prompt]
    if prompt != nil
      prompt
    end
  end

  def requires_target
    @@action_map[@action_id][:requires_target]
  end

  def succeed(current_player, current_action, deck)
    if current_action.get_id == "0" #Income
      current_player.add_coin(1)
    elsif current_action.get_id == "1" #Foreign aid
      current_player.add_coin(2)
    elsif current_action.get_id == "2" #Coup
      if current_player.get_coin_count >= 7
        current_player.add_coin(-7)
        @target_player.loses_influence
      else
        puts "Not enough coins.. Lose your turn for being dumb"
      end
    elsif current_action.get_id == "3" #Tax
      current_player.add_coin(3)
    elsif current_action.get_id == "4" #Assasinate
      if current_player.get_coin_count >= 3
        current_player.add_coin(-3)
        @target_player.loses_influence
      else
        puts "Asssasination fails. Not enough coins.. Lose your turn for being dumb"
      end
    elsif current_action.get_id == "5" #Exchange
      temporary_cards = [deck.get_random_influence, deck.get_random_influence]
      card_ids = temporary_cards[0].get_id + temporary_cards[1].get_id
      active_cards = get_active_character_cards
      original_active_card_count = active_cards.size
      active_cards.each do |card|
        card_ids += card.get_id
      end
      puts card_ids.join("\n")
      puts "Which cards do you want?"
      while new_card1 == nil
        card_id = gets.trim
        if card_ids.include? card_id
          if temporary_cards[0] && temporary_cards[0].get_id == card_id
            new_card1 = temporary_cards[0]
            temporary_cards.delete_at(0)
          elsif temporary_cards[1] && temporary_cards[1].get_id == card_id
            new_card1 = temporary_cards[1]
            temporary_cards.delete_at(1)
          elsif active_cards[0] && active_cards[0].get_id == card_id
            new_card1 = active_cards[0]
            active_cards.delete_at(0)
          else active_cards[1] && active_cards[1].get_id == card_id
            new_card1 = active_cards[1]
            active_cards.delete_at(1)
          end
        end
      end
      new_card1_id = new_card1.get_id
      card_ids.delete_at(card_ids.index(new_card1_id))
      if (original_active_card_count > 1)
        while new_card2 == nil
          card_id = gets.trim
          if card_ids.include? card_id
            if temporary_cards[0] && temporary_cards[0].get_id == card_id
              new_card2 = temporary_cards[0]
              temporary_cards.delete_at(0)
            elsif temporary_cards[1] && temporary_cards[1].get_id == card_id
              new_card2 = temporary_cards[1]
              temporary_cards.delete_at(1)
            elsif active_cards[0] && active_cards[0].get_id == card_id
              new_card2 = active_cards[0]
              active_cards.delete_at(0)
            else active_cards[1] && active_cards[1].get_id == card_id
              new_card2 = active_cards[1]
              active_cards.delete_at(1)
            end
          end
        end
      end

      cards_to_reinsert = active_cards + temporary_cards
      cards_to_reinsert.each do |card|
        deck.add_card(card)
      end

      current_player.set_card(1, new_card1)
      if new_card2
        current_player.set_card(2, new_card2)
      end
    elsif current_action.get_id == "6" #Steal
      if @target_player.get_coin_count > 1
        current_player.add_coin(2)
        @target_player.add_coin(-2)
      elsif @target_player.get_coin_count == 1
        @target_player.add_coin(-1)
        @target_player.add_coin(1)
      end
    end
  end

  def get_id
    @action_id
  end

  def self.show_all_actions
    action_list = []
    @@action_map.each_with_index do |index, action_info|
      action_list.push "#{index[0]} -- #{index[1][:description]}"
    end
    action_list
  end

  def to_s
    result = get_description
    if @target_player
      result = "#{result} on #{@target_player}"
    end
    result
  end
end

class Character
  @character_id
  @@character_map = {
    0 => {
      :name => "Duke",
      :action_id => "3",
      :counteract_action_id => "1"
    },
    1 => {
      :name => "Assassin",
      :action_id => "4",
      :counteract_action_id => "-1"
    },
    2 => {
      :name => "Ambassador",
      :action_id => "6",
      :counteract_action_id => "2"
    },
    3 => {
      :name => "Contessa",
      :action_id => "-1",
      :counteract_action_id => "4"
    },
    4 => {
      :name => "Captain",
      :action_id => "5",
      :counteract_action_id => "2"
    }
  }

  def initialize(id)
    @character_id = id
  end

  def get_all_characters()
    characters = []
    @@character_map.each_with_index do |character_info, index|
      characters.push(Character.new(index))
    end
    characters
  end

  def get_id
    @character_id
  end

  def get_counteraction_id
    get_character_data[:counteract_action_id]
  end

  def get_action_id
    get_character_data[:action_id]
  end

  def get_character_data
    @@character_map[@character_id]
  end
end

class InfluenceCard
  @character
  @active

  def initialize(character)
    @character = character
    @active = true
  end

  def get_counteraction_id
    @character.get_counteraction_id
  end

  def get_action_id
    @character.get_action_id
  end

  def reveal_card
    @active = false
  end

  def active?
    return @active
  end

  def get_id
    @character.get_id
  end

  def card_info
    data = @character.get_character_data
    data[:name]
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

  def get_random_influence
    @cards.shuffle!
    @cards.pop
  end

  def add_card(influence_card)
    @cards.push(influence_card)
  end

end

Game.new()