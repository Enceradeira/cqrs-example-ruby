require 'rspec'
require_relative '../../../lib/application/service_locator'
require_relative '../../../lib/application/app_service'

describe AppService do
  let(:app_service) { AppService.new }
  before(:each) { ServiceLocator.reset }

  describe 'register_person' do
    it 'adds person' do
      app_service.register_person('John')
      app_service.register_person('Alistair')

      expect(app_service.get_persons).to eq(%w(Alistair John))
    end
  end

  describe 'change_person_name' do
    it 'changes name' do
      app_service.register_person('John')
      id_alistair = app_service.register_person('Alistair')

      app_service.change_person_name(id_alistair, 'Zorro')

      expect(app_service.get_persons).to eq(%w(John Zorro))
    end
    it 'raises error when person not exists' do
      expect { app_service.change_person_name('not existing', 'Zorro') }.to raise_error(StandardError)
    end
  end


end