Dir["./lib/*.rb"].each do |file|
  require file
end

require 'byebug'

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
######

class Pandemic
  attr_accessor :game_over
  MAX_OUTBREAKS = 8
  MAX_INFECTIONS = 24

  def initialize(player_count = 1, difficulty = 2)
    @board = Board.new
    @players = []
    @infection_deck = Deck.new
    @city_deck = Deck.new
    @turns = []
    @current_turn = nil
    @outbreak_count = 0
    @actions_per_turn = 4
    initial_hand_size = 4
    pre_game_infection_rounds = 3
    infection_count_per_card = 3

    init_players(player_count)
    init_decks(difficulty)
    init_hands(initial_hand_size)
    infect_board(pre_game_infection_rounds, infection_count_per_card)
    add_epidemic_cards(difficulty)

    puts "======================================"
  end

  def play
    puts "==============GAME START=============="
    while game_over == false
      puts self
      turn

      @board.rate.times do
        infect
      end
    end
    puts "===============GAME END==============="
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
    @current_turn = Turn.new(current_player, @city_deck, @board)
    @turns << @current_turn

    @actions_per_turn.times do
      @current_turn.show_actions
      chosen_action = gets
      chosen_action = chosen_action.to_i
      @current_turn.act(chosen_action)
    end

    draw_city_cards(current_player, 2)

    # Discard down to max hand size if necessary
    discarded_cards = current_player.discard_down
    discarded_cards.each do |card|
      @city_deck.discard(card)
    end
  end

  def draw_city_cards(player, cards)
    cards.times do
      card = @city_deck.draw

      if card.kind_of? EpidemicCard
        @city_deck.discard(card)
        trigger_epidemic
      else
        player.hand << card
      end
    end
  end

  def infect(infection_count = 1)
    card = @infection_deck.draw
    puts card

    outbreaks_added = card.city.add_infection(infection_count)
    @outbreak_count += outbreaks_added
    @infection_deck.discard(card)

    outbreaks_added || 0
  end

  # Increase the infection rate
  # Infect the bottom card from the infection deck w/ 3 infections
  # Shuffle the discarded city cards and put them on the top of the deck
  def trigger_epidemic
    @board.increase_rate

    bottom_card = @infection_deck.bottom_draw
    outbreaks_added = bottom_card.city.add_infection(3)
    @outbreak_count += outbreaks_added

    @infection_deck.discard(bottom_card)
    @infection_deck.add_all_discard_to_deck
  end

  # Construct the starting decks
  def init_decks(epidemic_cards)
    # We initialize 2 decks with one card for each city
    @board.cities.each do |city_name, city|
      @city_deck.add_card(CityCard.new(city))
      @infection_deck.add_card(InfectionCard.new(city))
    end

    @city_deck.shuffle
    @infection_deck.shuffle
  end

  def init_hands(start_hand_size)
    @players.each do |player|
      start_hand_size.times do
        card = @city_deck.draw
        player.add_card(card)
      end
    end
  end

  # Pull 9 cards three at a time
  def infect_board(rounds, cards_per_round)
    rounds.times do |round|
      infections_per_card = rounds - round
      puts self
      cards_per_round.times do
        infect(infections_per_card)
      end
    end
  end

  def add_epidemic_cards(difficulty)
    difficulty.times do
      @city_deck.add_card(EpidemicCard.new)
    end

    # Fun to turn this off for Debug
    @city_deck.shuffle
  end

  # Describe the end condition of the game
  def game_over
    # We have too many outbreaks
    return true if @outbreak_count > MAX_OUTBREAKS

    # We run out of city cards?
    return true if @city_deck.empty?

    # We have no more infection cards to draw
    return true if @infection_deck.empty?

    # You're allowed a max of 24 infection cubes per disease
    return true if @board.total_infections > MAX_INFECTIONS

    false
  end

  # Print out the game state for debugging
  def to_s
    "
    Players:
        #{Util.show_list(@players)}
    Outbreak Count: #{@outbreak_count}
    Infection Rate: #{@board.rate}
    #{@board}
    Infection Deck:
      #{@infection_deck}
    City Deck:
      #{@city_deck}"
  end

end
