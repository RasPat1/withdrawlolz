# Let's start by initializing a fixed board
class Board
  attr_accessor :cities, :edges, :starting_city

  STARTING_CITY_NAME = "New York"
  CITY_LIST = [
    'Chicago', 'San Francisco',
    STARTING_CITY_NAME, 'Portland',
    'Austin', 'Boston', 'Los Angeles'
  ]

  # Let's manually create a group of cities
  def initialize(city_count = 7)
    @cities = init_cities(city_count)
    @starting_city = @cities[STARTING_CITY_NAME]
    connect_cities
  end

  def init_cities(city_count)
    cities = {}

    city_count.times do |index|
      city_name = CITY_LIST[index]
      cities[city_name] = City.new(city_name)
    end

    cities
  end

  def connect_cities
    edge_pairs = [
      [0, 1], [1, 2], [2, 3], [2, 4], [3, 5], [3, 6], [5,6]
    ]

    edge_pairs.each do |pair|
      from_city = City.find_by_id(pair[0])
      to_city = City.find_by_id(pair[1])

      # Make some custom exceptions
      if from_city == nil || to_city == nil
        raise Exception.new("City doesn't exist")
      end

      from_city.add_edge(to_city)
    end
  end

  def to_s
    "Cities:
      #{Util.show_hash(@cities, false)}"
  end

end