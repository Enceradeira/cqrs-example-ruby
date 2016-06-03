require_relative '../../lib/readmodel/database'
require_relative '../infrastructure/bus'
require_relative '../../lib/infrastructure/event_store'

class Resources
  class << self
    attr_reader :bus
    attr_reader :read_db
    attr_reader :event_store

    def reset
      @read_db = Database.new
      @bus = Bus.new
      @event_store = EventStore.new(@bus)
    end
  end

  reset
end