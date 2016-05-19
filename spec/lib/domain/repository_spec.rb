require 'rspec'
require_relative '../../../lib/domain/repository'
require_relative 'event_store_spy'


describe Repository do
  let(:event_store) { EventStoreSpy.new }
  let(:repository) { Repository.new(event_store) }
  let(:aggregate_class) { Struct.new(:id, :uncommitted_changes) }

  describe 'save' do

    it 'saves events in event store' do
      aggregate = aggregate_class.new(7, {})
      repository.save(aggregate, 20)

      saved_events = event_store.saved_events
      expect(saved_events).to eq([SaveEventArg.new(7, {}, 20)])

    end
  end
end