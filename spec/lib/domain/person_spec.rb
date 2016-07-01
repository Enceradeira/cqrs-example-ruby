require 'rspec'
require_relative '../../../lib/domain/person'

module Domain
  describe Person do

    describe 'initialize' do
      let(:initial_name) { 'John' }
      let(:person_id) { 4 }
      let(:person) { Person.new({id: person_id, name: initial_name}) }

      it 'marks person as registered' do
        changes = person.uncommitted_changes
        expect(changes).to eq([PersonRegistered.new(person_id, initial_name)])
      end

      describe 'and change_name' do

        it 'creates NameChanged event' do
          new_name = 'Mark'
          person.change_name(new_name)

          last_change = person.uncommitted_changes.last
          expect(last_change).to eq(NameChanged.new(person_id, new_name))
        end
      end
    end
  end
end