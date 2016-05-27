require 'rspec'
require_relative '../../../lib/infrastructure/event_store'
require_relative '../../../lib/infrastructure/concurrency_error'

describe EventStore do
  let(:store) { EventStore.new }

  describe 'save_events' do

    [0, 1].each do |invalidated_version|
      it "raises concurrency error when current version is 2 but update is on version #{invalidated_version}" do
        store.save_events({}, [{}], nil) # create
        store.save_events({}, [{}], 0) # update on version 0
        store.save_events({}, [{}], 1) # update on version 1

        expect { store.save_events({}, [{}], invalidated_version) }.to raise_error(ConcurrencyError)
      end
    end

    it 'publishes saved events' do
      store.save_events({}, [{}], nil) # create


    end

  end
end

