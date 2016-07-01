require 'rspec'
require_relative '../../../lib/application/app_service'
require_relative '../../../lib/infrastructure/concurrency_error'

module Application
  describe AppService do
    let(:app_service) { AppService.new }

    describe 'register_person' do

      it 'adds person' do
        app_service.register_person('John')
        app_service.register_person('Alistair')

        expect(app_service.get_persons).to eq(%w(Alistair John))
      end
    end

    describe 'get_person' do

      it 'returns person data' do
        id = app_service.register_person('John')

        person = app_service.get_person(id)

        expect(person).to eq({id: id, name: 'John', version: 0})
      end
    end

    describe 'change_person_name' do

      it 'changes name' do
        app_service.register_person('John')
        id_alistair = app_service.register_person('Alistair')

        app_service.change_person_name(id_alistair, 'Zorro', 0)

        expect(app_service.get_persons).to eq(%w(John Zorro))
      end

      it 'raises error when person not exists' do
        expect { app_service.change_person_name('not existing', 'Zorro') }.to raise_error(StandardError)
      end

      it 'raises exception when conflicting name change' do
        change_name = lambda { |person, new_name| app_service.change_person_name(person[:id], new_name, person[:version]) }

        # create a person
        person_id = app_service.register_person('C.')

        # session 1 & 2 load person data
        person_on_session1 = app_service.get_person(person_id)
        person_on_session2 = app_service.get_person(person_id)

        # session 1 updates person successfully
        change_name.call(person_on_session1, 'Carlos')

        # session 2 CAN'T update on stale data
        expect { change_name.call(person_on_session2, 'Claudio') }.to raise_error(StandardError)
      end
    end

    describe 'deregister_person' do

      it 'removes person' do
        id = app_service.register_person('Mary')

        app_service.deregister_person(id, 0)

        expect(app_service.get_persons).to be_empty
      end
    end

  end
end