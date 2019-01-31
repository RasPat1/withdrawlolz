Dir["./lib/*.rb"].each do |file|
  require file
end
#####
# Create a group of cities
# Connect those cities (fixed start right now)
# Create a shuffled deck of city cards
# Create a shuffled deck of infection cards
# Add players in starting city
# Distribute N city cards to each player
# Infect X cities with Y infections in Z rounds
# Each player gets 4 actions
# Code each of the actions
# Keep track of total outbreaks
######

class Pandemic < LibBase
  attr_accessor :game_over

  def initialize(player_count = 1)
    @board = Board.new
    @players = []
    @infection_deck = Deck.new
    @city_deck = Deck.new
    @game_over = false
    @turns = []
    @current_turn = nil
    @outbreak_count = 0

    # subscribe to applicable events
    subscribe

    init_players(player_count)
    init_decks
    infect_board(2,2)

    puts "START"
    while !@game_over
      puts self
      turn
    end
  end

  def subscribe


PubSub.subscribe(

PubSub::OUTBREAK)
  end

  def receive_event(event_type, value)
    case event_type
    when

PubSub::OUTBREAK
      @outbreaks += 1
    end
  end

  def init_players(player_count)
    player_count.times do
      @players << Player.new("P1", @board.starting_city)
    end
  end

  # Once we have the game set up
  # players can take a turn
  def turn
    current_player = @players.shift
    @players << current_player
    @current_turn = Turn.new(current_player)
    @turns << @current_turn

    @current_turn.show_actions
    chosen_action = gets
    # Take the action
    # Display any other prompts necessary for the action to be completed
    puts chosen_action
  end

  # Describe the end condition of the game
  def game_over
    # 8 outbreaks happen
    # we run out of ctiy cards?
    # we run out of infection cards
    #
    @game_over
  end

  # Pull 9 cards three at a time
  def infect_board(rounds, cards_per_round)
    rounds.times do |round|
      infections_per_card = rounds - round
      cards_per_round.times do |card_num|
        card = @infection_deck.draw
        card.city.add_infection(infections_per_card)
        @infection_deck.discard(card)
      end
    end
  end

  # Construct the starting decks
  def init_decks
    # We initialize 2 decks with one card for each city
    @board.cities.each do |city_name, city|
      @city_deck.add_card(CityCard.new(city))
      @infection_deck.add_card(InfectionCard.new(city))
    end

    @city_deck.shuffle
    @infection_deck.shuffle
  end

  # Print out the game state for debugging
  def to_s
    "
    Players:
        #{Util.show_list(@players)}
    #{@board}
    Infection Deck:
      #{@infection_deck}
    City Deck:
      #{@city_deck}"
  end

end