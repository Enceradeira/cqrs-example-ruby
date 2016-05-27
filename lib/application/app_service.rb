require_relative 'service_locator'
require_relative 'commands'
require_relative 'sequence'

class AppService
  private
  def initialize
    @bus = ServiceLocator.bus
    @person_facade = PersonFacade.new(ServiceLocator.read_db)
  end

  public
  def register_person(name)
    person_id = Sequence.next
    @bus.send_cmd(RegisterPerson.new(person_id, name))
    person_id
  end

  def change_person_name(person_id, new_name)
    person = @person_facade.get_person(person_id)
    @bus.send_cmd(ChangePersonName.new(person_id, new_name, person[:version]))
  end

  def get_persons
    @person_facade.get_persons
  end

end