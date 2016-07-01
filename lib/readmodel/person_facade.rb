module ReadModel
  class PersonFacade
    private
    def initialize(db)
      @db = db
    end

    public
    def get_persons
      @db.persons.map { |p| p[:name] }
    end

    def get_person(person_id)
      person = @db.persons.find { |p| p[:id] == person_id }
      raise StandardError.new "person #{person_id} not found" if person.nil?
      person.clone
    end
  end
end
