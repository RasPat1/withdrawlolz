class Card < LibBase
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

# Not implemented yet
class EventCard
end