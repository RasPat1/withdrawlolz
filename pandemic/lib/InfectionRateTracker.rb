class InfectionRateTracker
  TRACK = [2,2,2,3,3,4,4]

  def initialize
    @index = 0
  end

  def increase_rate
    @index += 1
  end

  def rate
    TRACK[@index]
  end
end
