require_relative 'database'

module ReadModel
  class PersonModelUpdater
    private
    def initialize(database)
      @database = database
    end

    def sort_persons
      @database.persons.sort! { |a, b| a[:name] <=> b[:name] }
    end

    def find_person(event)
      person_id = event.person_id
      person = @database.persons.find { |p| p[:id] == person_id }
      raise StandardError "Person #{person_id} not found" if person.nil?
      person
    end

    public
    def person_registered(event_desc)
      event = event_desc.event
      @database.persons << {id: event.person_id, name: event.name, version: event_desc.version}
      sort_persons
    end

    def person_deregistered(event_desc)
      event = event_desc.event
      record = find_person(event)
      @database.persons.delete(record)
    end

    def name_changed(event_desc)
      event = event_desc.event
      record = find_person(event)
      record[:name] = event.new_name
      record[:version] = event_desc.version
      sort_persons
    end
  end
end