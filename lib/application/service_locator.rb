require_relative 'resources'
require_relative 'command_handler'
require_relative '../infrastructure/bus'
require_relative '../../lib/domain/repository'
require_relative '../../lib/readmodel/person_facade'
require_relative '../../lib/readmodel/database'
require_relative '../../lib/readmodel/person_model_updater'

class ServiceLocator
  class << self
    def read_db
      Resources.read_db
    end

    def command_bus
      Resources.bus
    end

    def reset
      Resources.reset

      event_bus = Bus.new
      # command bus registrations
      repository = Repository.new(EventStore.new(event_bus))
      command_bus.register_handler(CommandHandler.new(repository))
      # event bus registrations
      person_updater = PersonModelUpdater.new(read_db)
      event_bus.register_handler(person_updater)
    end
  end

  reset
end
