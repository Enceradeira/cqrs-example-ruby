require_relative 'app_service'
require_relative 'command_handler'
require_relative '../infrastructure/bus'
require_relative '../../lib/domain/repository'
require_relative '../../lib/infrastructure/event_store'
require_relative '../../lib/readmodel/person_facade'
require_relative '../../lib/readmodel/database'
require_relative '../../lib/readmodel/person_model_updater'

class ServiceLocator
  class << self
    attr_reader :bus
    attr_reader :read_db

    def reset
      @read_db = Database.new
      @bus = Bus.new
      # command bus
      repository = Repository.new(EventStore.new(@bus))
      @bus.register_handler(CommandHandler.new(repository))
      # event bus
      person_updater = PersonModelUpdater.new(@read_db)
      @bus.register_handler(person_updater)
    end
  end

  reset
end