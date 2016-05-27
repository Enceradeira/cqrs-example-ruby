require 'rspec'
require_relative '../../../lib/domain/repository'
require_relative '../../../lib/domain/events'
require_relative 'event_store_spy'
require_relative 'event_store_stub'


describe Repository do
  let(:repository) { Repository.new(event_store) }
  let(:aggregate_class) { Struct.new(:id, :uncommitted_changes) }

  describe 'save' do
    let(:event_store) { EventStoreSpy.new }

    it 'saves events in event store' do
      aggregate = aggregate_class.new(7, {})
      repository.save(aggregate, 20)

      saved_events = event_store.saved_events
      expect(saved_events).to eq([SaveEventArg.new(7, {}, 20)])

    end
  end

  describe 'get_person' do
    let(:event_store) { EventStoreStub.new }

    it 'returns saved person' do
      event_store.add_event(PersonRegistered.new(34, 'Mayra'))

      person = repository.get_person(34)

      expect(person).to_not be_nil
    end
  end
end