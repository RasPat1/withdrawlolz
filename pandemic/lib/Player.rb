class Player
  attr_accessor :name, :location

  def initialize(name, location = nil)
    @name = name
    @location = location
  end

  # fails to move ne location is not connected to old location
  # Updates locatio and returns true if move is succesful
  def move(new_location)
    # prob throm an error
    return false unless location.is_connected(new_location)
    location = new_location

    true
  end

  def to_s
    "#{name}"
  end
end