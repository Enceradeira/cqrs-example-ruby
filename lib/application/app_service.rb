require_relative 'commands'
require_relative 'sequence'
require_relative 'registry'
require_relative '../../lib/infrastructure/command_backup'
require_relative '../../lib/readmodel/person_facade'

module Application
  class AppService
    private

    def bus
      Registry.command_bus
    end

    def person_facade
      ReadModel::PersonFacade.new(Registry.read_db)
    end

    public
    def register_person(name)
      person_id = Sequence.next
      bus.send_cmd(RegisterPerson.new(person_id, name))
      person_id
    end

    def change_person_name(person_id, new_name, original_version)
      bus.send_cmd(ChangePersonName.new(person_id, new_name, original_version))
    end

    def get_persons
      person_facade.get_persons
    end

    def get_person(person_id)
      person_facade.get_person(person_id)
    end

    def deregister_person(person_id, original_version)
      bus.send_cmd(DeregisterPerson.new(person_id, original_version))
    end

  end
end