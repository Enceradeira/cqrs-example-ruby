require_relative 'app_service'
require_relative 'command_handler'
require_relative '../infrastructure/bus'
require_relative '../../lib/domain/repository'
require_relative '../../lib/infrastructure/event_store'
require_relative '../../lib/readmodel/person_facade'
require_relative '../../lib/readmodel/database'
require_relative '../../lib/readmodel/person_model_updater'

class ServiceLocator
  @read_db = Database.new

  class << self
    private


    public
    def app_service
      AppService.new
    end

    def bus
      if @bus == nil
        @bus = Bus.new
        # command bus
        repository = Repository.new(EventStore.new(@bus))
        @bus.register_handler(CommandHandler.new(repository))
        # event bus
        person_updater = PersonModelUpdater.new
        @bus.register_handler(person_updater)
      end
      @bus
    end

    def person_facade
      PersonFacade.new(@read_db)
    end
  end
end