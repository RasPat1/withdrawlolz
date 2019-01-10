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

    @neighbors << city
    @neighbors = @neighbors.uniq

    city.neighbors << self
    city.neighbors = city.neighbors.uniq

    self
  end

  # We need to add infection types here
  def add_infection(count = 1, source_cities = [])
    return nil if source_cities.include?(self)

    if infections + count > OUTBREAK_MAX
      infect_surrounding(count, [self])
    else
      @infections += count
    end
  end

  def infect_surrounding(count, source_cities = [self])
    neighbors.each do |city|
      add_infection(count, source_cities += self)
    end
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
