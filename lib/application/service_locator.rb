require_relative 'resources'
require_relative 'command_handler'
require_relative '../infrastructure/bus'
require_relative '../../lib/infrastructure/command_backup'
require_relative '../../lib/domain/repository'
require_relative '../../lib/readmodel/person_facade'
require_relative '../../lib/readmodel/database'
require_relative '../../lib/readmodel/person_model_updater'

class ServiceLocator
  class << self
    private
    def reset
      # command bus registrations
      repository = Domain::Repository.new(Resources.event_store)
      command_bus.register_handler(CommandHandler.new(repository))
      command_bus.register_handler(Resources.command_backup)
      # event bus registrations
      person_updater = ReadModel::PersonModelUpdater.new(read_db)
      Resources.event_bus.register_handler(person_updater)
    end

    public
    def read_db
      Resources.read_db
    end

    def command_bus
      Resources.command_bus
    end

    def command_backup
      Resources.command_backup
    end

  end

  reset
  Resources.call_on_reset {reset}
end
