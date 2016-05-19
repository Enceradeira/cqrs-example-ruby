require 'rspec'
require_relative '../../../lib/domain/repository'
require_relative 'event_store_spy'

describe Repository do
  let(:event_store){EventStoreSpy.new}
  let(:repository){Repository.new(event_store)}

  describe 'save' do

    it 'saves events in event store' do
        event = {}
        repository.save(event,-1)

        pending

    end
  end
end