require 'rspec'
require_relative '../../../lib/application/sequence'

describe Sequence do

  describe 'next' do

    it 'creates sequence' do
      v1 = Sequence.next
      v2 = Sequence.next
      v3 = Sequence.next

      expect(v2).to be > v1
      expect(v3).to be > v2
    end

  end
end