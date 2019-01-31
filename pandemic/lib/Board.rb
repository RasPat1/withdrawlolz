class Board
  attr_accessor :cities, :edges, :starting_city

  # Let's manually create a group of cities
  def initialize
    config = Config.new

    @cities = init_cities(config.city_list)
    @starting_city = @cities[config.starting_city]
    connect_cities(config.edges)
  end

  def init_cities(city_list)
    cities = {}

    city_list.each do |city_name|
      cities[city_name] = City.new(city_name)
    end

    cities
  end

  def connect_cities(edge_pairs)
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