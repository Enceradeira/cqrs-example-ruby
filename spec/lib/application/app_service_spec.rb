require 'rspec'
require_relative '../../../lib/application/service_locator'
require_relative '../../../lib/application/app_service'

describe AppService do
  let(:app_service) { ServiceLocator.app_service }
  describe 'register_person' do
    it 'should add person' do
      app_service.register_person('John')
      app_service.register_person('Alistair')

      persons = app_service.get_persons

      expect(persons).to eq(%w(Alistair John))
    end
  end


end