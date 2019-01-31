class PubSub
  TYPES = [
    OUTBREAK = :outbreak
  ]

  attr_accessor :subscribers

  # Init an empty list for each event_type
  def initialize
    @subscribers = {}
    TYPES.each do |event_type|
      @subscribers[event_type] = []
    end
  end

  def publish(event_type, value)
    # We could put a queue in here but not needed yet
    @subscribers[event_type].each do |subscriber|
      subscriber.receive_event(event_type, value)
    end
  end
end