require_relative 'database'

class PersonModelUpdater
  private
  def initialize(database)
    @database = database
  end

  def sort_persons
    @database.persons.sort! { |a, b| a[:name] <=> b[:name] }
  end

  public
  def person_registered(event_descriptor)
    event = event_descriptor.event
    @database.persons << {id: event.person_id, name: event.name, version: event_descriptor.version}
    sort_persons
  end

  def name_changed(event_descriptor)
    event = event_descriptor.event
    record = @database.persons.find { |p| p[:id] == event.person_id }
    record[:name] = event.new_name
    record[:version] = event_descriptor.version
    sort_persons
  end
end