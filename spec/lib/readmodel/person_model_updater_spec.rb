require 'rspec'
require_relative '../../../lib/readmodel/person_model_updater'
require_relative '../../../lib/infrastructure/event_descriptor'
require_relative '../../../lib/domain/events'

def person_registered_event(id, name, version)
  EventDescriptor.new(version, PersonRegistered.new(id, name))
end

def name_changed_event(id, new_name, version)
  EventDescriptor.new(version, NameChanged.new(id, new_name))
end

describe PersonModelUpdater do
  let(:database) { Database.new }
  let(:updater) { PersonModelUpdater.new(database) }

  describe 'person_registered' do

    it 'adds person to database' do
      updater.person_registered(person_registered_event(45, 'Maria', 0))
      expect(database.persons).to eq([{id: 45, name: 'Maria', version: 0}])
    end

    it 'orders persons alphabetically' do
      updater.person_registered(person_registered_event(1, 'Maria', 5))
      updater.person_registered(person_registered_event(2, 'Alistair', 7))

      expect(database.persons).to eq([{id: 2, name: 'Alistair', version: 7}, {id: 1, name: 'Maria', version: 5}])
    end
  end

  describe 'name_changed' do

    it 'changes name of person' do
      updater.person_registered(person_registered_event(1, 'Maria', 0))
      updater.person_registered(person_registered_event(2, 'Alistair', 0))
      updater.name_changed(name_changed_event(2, 'Zorro', 1))

      expect(database.persons).to eq([{id: 1, name: 'Maria', version: 0}, {id: 2, name: 'Zorro', version: 1}])
    end
  end
end