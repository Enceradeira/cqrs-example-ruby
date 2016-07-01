require_relative '../../lib/readmodel/database'
require_relative '../infrastructure/bus'
require_relative '../../lib/infrastructure/event_store'
require_relative '../../lib/infrastructure/command_backup'

class Resources
  @reset_handlers = []

  class << self
    public
    attr_reader :event_bus
    attr_reader :command_bus
    attr_reader :read_db
    attr_reader :event_store
    attr_reader :command_backup

    def reset
      @read_db = Database.new
      @event_bus = Bus.new
      @event_store = EventStore.new(@event_bus)
      @command_bus = Bus.new
      @command_backup = CommandBackup.new

      @reset_handlers.each { |handler| handler.call }
    end

    def call_on_reset(&block)
      raise StandardError.new 'block expected' unless block_given?
      @reset_handlers << block
    end
  end

  reset
end