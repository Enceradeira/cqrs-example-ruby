require_relative 'service_locator'
require_relative 'register_person'
require_relative 'sequence'

class Service
  public
  def register_person(name)
    bus = ServiceLocator.bus

    bus.send_cmd(RegisterPerson.new(Sequence.next, name))
  end

  def get_persons
    []
  end

end