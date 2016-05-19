require_relative '../../lib/domain/person'

class CommandHandler
  def initialize(repository)
    @repository = repository
  end
  def register_person(msg)
    person = Person.new(msg.person_id, msg.name)
    @repository.save(person, -1)
  end
end