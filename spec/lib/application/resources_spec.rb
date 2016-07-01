require 'rspec'
require_relative '../../../lib/application/resources'

module Application
  describe Resources do

    describe 'reset' do
      it 'calls reset handler' do
        nr_calls = 0
        Resources.call_on_reset { nr_calls = nr_calls+1 }

        nr_resets = 3
        nr_resets.times { Resources.reset }

        expect(nr_calls).to eq(nr_resets)
      end
    end
  end
end