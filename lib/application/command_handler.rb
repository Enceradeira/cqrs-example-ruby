require_relative '../../lib/domain/person'

class CommandHandler
  def initialize(repository)
    @repository = repository
  end

  def register_person(cmd)
    person = Person.new({id: cmd.person_id, name: cmd.name})
    @repository.save(person, -1)
  end

  def change_person_name(cmd)
    person = @repository.get_person(cmd.person_id)
    person.change_name(cmd.new_name)
    @repository.save(person, cmd.original_version)
  end
end