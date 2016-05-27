class EventStore
  EventDescriptor = Struct.new(:version, :event)

  def initialize
    @events = Hash.new { |_, _| [] }
  end

  public
  def save_events(aggregate_id, new_events, expected_version)
    events = @events[aggregate_id]
    last_event = events.last
    raise ConcurrencyError.new unless last_event.nil? || last_event.version == expected_version
    new_events.each do |event|
      events << EventDescriptor.new(last_event.nil? ? 0 : last_event.version + 1, event)
    end
    @events[aggregate_id] = events


  end
end