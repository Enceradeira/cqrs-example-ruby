require 'rspec'
require_relative '../../../lib/readmodel/person_facade'
require_relative '../../../lib/readmodel/database'

describe PersonFacade do
  let(:database) { Database.new }
  let(:facade) { PersonFacade.new(database) }

  let(:john) { {id: 1, name: 'John', version: 8} }
  let(:fiona) { {id: 2, name: 'Fiona', version: 2} }

  before(:each) do
    database.persons << john
    database.persons << fiona
  end

  describe 'get_persons' do
    it {expect(facade.get_persons).to eq(%w(John Fiona))}
  end

  describe 'get_person' do
    it 'returns person' do
      expect(facade.get_person(john[:id])).to eq(john)
    end

    it 'raises error when person not exists' do
      expect { facade.get_person('not existing') }.to raise_error(StandardError)
    end

  end
end