require 'rspec'
require_relative '../../../lib/infrastructure/event_store'
require_relative '../../../lib/infrastructure/concurrency_error'
require_relative '../../../lib/infrastructure/event_descriptor'
require_relative 'event_publisher_spy'

describe EventStore do
  let(:store) { EventStore.new(publisher) }
  let(:publisher) { EventPublisherSpy.new }

  describe 'save_events' do

    [0, 1].each do |invalidated_version|
      it "raises concurrency error when current version is 2 but update is on version #{invalidated_version}" do
        aggregate_id = 7
        store.save_events(aggregate_id, [{}], nil) # create
        store.save_events(aggregate_id, [{}], 0) # update on version 0
        store.save_events(aggregate_id, [{}], 1) # update on version 1

        expect { store.save_events(aggregate_id, [{}], invalidated_version) }.to raise_error(ConcurrencyError)
      end
    end

    it 'does not raise concurrency error same version but different aggregate' do
      store.save_events(2, [{}], nil) # create
      expect { store.save_events(3, [{}], nil) }.not_to raise_error
    end

    it 'publishes saved events' do
      evt1, evt2, evt3 ='A', 'B', 'C'

      store.save_events(7, [evt1], nil)
      store.save_events(7, [evt2, evt3], 0)

      expect(publisher.published_events).to eq([EventDescriptor.new(0, evt1),
                                                EventDescriptor.new(1, evt2),
                                                EventDescriptor.new(2, evt3)])
    end
  end
end

