require_relative 'database'

class PersonModelUpdater
  private
  def initialize(database)
    @database = database
  end
  public
  def person_registered(event_descriptor)
    event =  event_descriptor.event
    @database.persons << event.name
    @database.persons.sort!
  end
end