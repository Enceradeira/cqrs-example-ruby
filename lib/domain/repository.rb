require_relative 'person'

class Repository
  private
  def initialize(storage)
    @storage = storage
  end

  public
  def save(aggregate, expected_version)
    @storage.save_events(aggregate.id, aggregate.uncommitted_changes, expected_version)
  end

  def get_person(person_id)
    events = @storage.get_events_for_aggregate(person_id)
    person = Person.new(events)
    return person
  end
end