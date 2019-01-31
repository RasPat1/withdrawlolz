class City < LibBase
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
  # We want to keep track of total number of outbreaks
  def add_infection(count = 1, source_cities = [])
    return nil if source_cities.include?(self)

    if infections + count > OUTBREAK_MAX
      outbreak(count, source_cities << self)
    else
      @infections += count
    end
  end

  # I'm actually a little unclear on what the rules are
  # here.
  # Todo: Clarify the rules when you get off this plane
  def outbreak(count, source_cities = [self])
    publish_outbreak
    neighbors.each do |city|
      city.add_infection(count, source_cities)
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

  def receive_event(event_type, value)
    case event_type
    when
      PubSub::OUTBREAK
      # do something
    end
  end

  def publish_outbreak
    PubSub.publish(PubSub::OUTBREAK, nil)
  end
end