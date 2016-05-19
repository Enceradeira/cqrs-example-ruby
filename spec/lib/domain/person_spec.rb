require 'rspec'
require_relative '../../../lib/domain/person'

describe Person do

  describe 'initialize' do

    it 'marks person as registered' do
      name = 'John'
      person_id = 4
      person = Person.new(person_id, name)
      changes = person.uncommitted_changes
      expect(changes).to eq([PersonRegistered.new(person_id, name)])
    end
  end
end