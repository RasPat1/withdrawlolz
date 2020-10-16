class City
  attr_accessor :name, :id, :neighbors, :infections

  OUTBREAK_MAX = 3

  @@id = -1
  @@all_cities = []

  def initialize(name)
    @name = name
    @neighbors = []
    @infections = 0
    @@id += 1
    @id = @@id
    @@all_cities << self
  end

  def add_edge(city)
    return nil unless city.kind_of? City
    return nil if city == self

    @neighbors << city
    @neighbors = @neighbors.uniq

    city.neighbors << self
    city.neighbors = city.neighbors.uniq

    self
  end

  def is_connected(other_city)
    neighbors.include?(other_city)
  end

  # We need to add infection types here
  # We want to keep track of total number of outbreaks
  def add_infection(count = 1, source_cities = [])
    outbreaks_added = 0
    return 0 if source_cities.include?(self)

    if @infections + count > OUTBREAK_MAX
      # I'm actually a little unclear on what the rules are
      # here.
      # Todo: Clarify the rules when you get off this plane
      source_cities << self
      neighbors.each do |city|
        outbreaks_added += city.add_infection(count, source_cities)
      end
    else
      @infections += count
    end

    outbreaks_added
  end

  def remove_infection(count = 1)
    # Infection count in a city can't be negative
    @infections -= count if @infections >= count
  end

  def self.find_by_id(id)
    @@all_cities[id]
  end

  def to_long_s
    "#{@name}:
        Neighbors: #{Util.show_list(neighbors)}
        Infection Count: #{@infections}"
  end
  def to_s
    @name
  end
end
