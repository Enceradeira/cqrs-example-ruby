require 'rspec'
require_relative '../../../lib/infrastructure/bus'

class ReceiveThis

end

class DoNotHandle

end


class Handler
  attr_reader :command
  attr_reader :nr_calls_to_receive_command

  def initialize
    @nr_calls_to_receive_command = 0
  end

  def receive_this(cmd)
    @command = cmd
    @nr_calls_to_receive_command = @nr_calls_to_receive_command + 1
  end
end

describe Bus do
  let(:bus) { Bus.new }
  let(:handler) { Handler.new }

  describe 'send_cmd' do
    let(:cmd) { ReceiveThis.new }
    before(:each) { bus.register_handler(handler) }

    it 'forwards command to handler' do
      bus.send_cmd(cmd)
      expect(handler.command).to eq(cmd)
    end

    it 'forwards command once' do
      bus.send_cmd(cmd)
      expect(handler.nr_calls_to_receive_command).to eq(1)
    end

    it "ignores handler that don't handle command" do
      cmd = DoNotHandle.new
      expect(lambda{bus.send_cmd(cmd)}).to_not raise_exception
    end
  end

end