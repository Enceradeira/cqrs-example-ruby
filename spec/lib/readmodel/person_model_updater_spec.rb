require 'rspec'
require_relative '../../../lib/readmodel/person_model_updater'
require_relative '../../../lib/infrastructure/event_descriptor'
require_relative '../../../lib/domain/person_registered'

def person_registered_event(id, name)
  EventDescriptor.new(nil, PersonRegistered.new(id, name))
end

describe PersonModelUpdater do
  let(:database) { Database.new }
  let(:updater) { PersonModelUpdater.new(database) }

  describe 'person_registered' do

    it 'adds person to database' do
      updater.person_registered(person_registered_event(45, 'Maria'))
      expect(database.persons).to eq(['Maria'])
    end

    it 'orders persons alphabetically' do
      updater.person_registered(person_registered_event(1, 'Maria'))
      updater.person_registered(person_registered_event(2, 'Alistair'))

      expect(database.persons).to eq(%w(Alistair Maria))
    end
  end
end