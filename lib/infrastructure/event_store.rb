require_relative 'event_descriptor'

class EventStore

  def initialize(publisher)
    @publisher = publisher
    @events = Hash.new { |_, _| [] }
  end

  public
  def save_events(aggregate_id, new_events, expected_version)
    events = @events[aggregate_id]
    last_event = events.last
    raise ConcurrencyError.new unless last_event.nil? || last_event.version == expected_version

    # add new events as event descriptor
    new_events_descriptors = new_events.map.with_index do |event, idx|
      next_version = last_event.nil? ? 0 : last_event.version + 1 + idx
      EventDescriptor.new(next_version, event)
    end
    events.concat(new_events_descriptors)
    @events[aggregate_id] = events

    # publish new events
    new_events_descriptors.each { |event| @publisher.publish(event) }
  end
end