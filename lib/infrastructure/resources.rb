require_relative '../../lib/readmodel/database'
require_relative '../infrastructure/bus'
require_relative '../../lib/infrastructure/event_store'
require_relative '../../lib/infrastructure/command_backup'
require_relative '../../lib/application/registry'
require_relative '../../lib/domain/repository'
require_relative '../application/command_handler'
require_relative '../../lib/readmodel/person_model_updater'

module Infrastructure
  class Resources
    @reset_handlers = []

    class << self
      public

      def init
        registry = Application::Registry
        registry.register_read_db(ReadModel::Database.new)
        bus = Bus.new
        registry.register_event_bus(bus)
        registry.register_event_store(EventStore.new(bus))
        registry.register_command_bus(bus)
        registry.register_command_backup(CommandBackup.new)


        # command bus registrations
        repository = Domain::Repository.new(registry.event_store)
        registry.command_bus.register_handler(CommandHandler.new(repository))
        registry.command_bus.register_handler(registry.command_backup)
        # event bus registrations
        person_updater = ReadModel::PersonModelUpdater.new(registry.read_db)
        registry.event_bus.register_handler(person_updater)

      end
    end
    init
  end
end