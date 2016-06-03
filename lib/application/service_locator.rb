require_relative 'resources'
require_relative 'command_handler'
require_relative '../../lib/domain/repository'
require_relative '../../lib/readmodel/person_facade'
require_relative '../../lib/readmodel/database'
require_relative '../../lib/readmodel/person_model_updater'

class ServiceLocator
  class << self
    def read_db
      Resources.read_db
    end

    def bus
      Resources.bus
    end

    def reset
      Resources.reset
      # command bus
      repository = Repository.new(EventStore.new(bus))
      bus.register_handler(CommandHandler.new(repository))
      # event bus
      person_updater = PersonModelUpdater.new(read_db)
      bus.register_handler(person_updater)
    end
  end

  reset
end
