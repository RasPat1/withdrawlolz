Dir["../lib/*.rb"].each { |file| require file}

class Pandemic
  def initialize(player_count = 1)
    @board = Board.new
    @players = []
    @infection_deck = Deck.new
    @city_deck = Deck.new

    init_players(player_count)
    init_decks
    infect_board(2,2)

    # while !game_over
    #   turn
    # end
    puts self
  end

  def init_players(player_count)
    player_count.times do
      @players << Player.new("P1", @board.starting_city)
    end
  end

  # Once we have hte game set up
  # players can take a turn
  def turn
  end

  # Describe the end condition of the game
  def game_over
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







