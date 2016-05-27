require_relative 'service_locator'
require_relative 'register_person'
require_relative 'sequence'

class AppService
  public
  def register_person(name)
    bus = ServiceLocator.bus

    bus.send_cmd(RegisterPerson.new(Sequence.next, name))
  end

  def change_person_name(person_id, new_name)

  end

  def get_persons
    person_facade = PersonFacade.new(ServiceLocator.read_db)

    person_facade.get_persons
  end

end