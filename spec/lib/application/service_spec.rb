require 'rspec'
require_relative '../../../lib/application/service_locator'
require_relative '../../../lib/application/service'

describe Service do
  let(:service) { ServiceLocator.service }
  describe 'register_person' do
    it 'should add person' do
      service.register_person('John')

      persons = service.get_persons

      expect(persons).to eq(['John'])
    end
  end
end