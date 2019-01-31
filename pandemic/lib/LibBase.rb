require './interface/PubSub.rb'

class LibBase
  def publish(event_type, value)
    PubSub.publish(event_type, value)
  end
  def receive_event(event_type, value)
    # no-op
    # override in subclasses
  end
end