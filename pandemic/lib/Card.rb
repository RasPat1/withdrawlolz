class Card
  attr_accessor :city

  def initialize(city)
    @city = city
  end

  def to_s
    "#{@city.name}"
  end
end

class CityCard < Card
end

class InfectionCard < Card
end

class EpidemicCard
  def initialize
  end

  def to_s
    "Epidemic!"
  end
end

# Not implemented yet
class EventCard
end