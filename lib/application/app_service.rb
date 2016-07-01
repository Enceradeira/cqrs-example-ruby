require_relative 'service_locator'
require_relative 'commands'
require_relative 'sequence'
require_relative 'resources'
require_relative '../../lib/infrastructure/command_backup'

module Application
  class AppService
    private

    def bus
      ServiceLocator.command_bus
    end

    def person_facade
      ReadModel::PersonFacade.new(ServiceLocator.read_db)
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

    def backup_and_restore
      commands = ServiceLocator.command_backup.commands

      Resources.reset

      commands.each do |cmd|
        bus.send_cmd(cmd)
      end
    end
  end
end