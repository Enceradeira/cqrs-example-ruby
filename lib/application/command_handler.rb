require_relative '../../lib/domain/person'

class CommandHandler
  private
  def initialize(repository)
    @repository = repository
  end

  def change_person_with(cmd)
    person = @repository.get_person(cmd.person_id)
    yield person
    @repository.save(person, cmd.original_version)
  end

  public
  def register_person(cmd)
    person = Domain::Person.new({id: cmd.person_id, name: cmd.name})
    @repository.save(person, -1)
  end

  def deregister_person(cmd)
    change_person_with(cmd) { |p| p.deregister() }
  end

  def change_person_name(cmd)
    change_person_with(cmd) { |p| p.change_name(cmd.new_name) }
  end
end