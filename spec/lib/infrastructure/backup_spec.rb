require 'rspec'
require_relative '../../../lib/application/app_service'
require_relative '../../../lib/infrastructure/backup'

module Infrastructure
  describe Backup do
    let(:app_service) { Application::AppService.new }

    describe 'backup_and_restore' do
      it 'should recreate previous state' do
        id_john = app_service.register_person('John')
        id_alistair = app_service.register_person('Alistair')
        app_service.register_person('Betty')
        app_service.change_person_name(id_alistair, 'John', 0)
        app_service.change_person_name(id_john, 'Cameron', 0)
        app_service.deregister_person(id_john, 1)
        observed_state = app_service.get_persons

        Backup.backup_and_restore

        expect(app_service.get_persons).to eq(observed_state)
      end
    end
  end
end