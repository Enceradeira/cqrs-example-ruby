require_relative 'service'
require_relative 'command_handler'
require_relative '../infrastructure/bus'
require_relative '../../lib/domain/repository'
require_relative '../../lib/infrastructure/event_store'

class ServiceLocator
  class << self
    def service
      Service.new
    end
    def bus
      if @bus == nil
        @bus = Bus.new
        repository = Repository.new(EventStore.new)
        @bus.register_handler(CommandHandler.new(repository))
      end
      @bus
    end
  end
end