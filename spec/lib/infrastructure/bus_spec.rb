require 'rspec'
require_relative '../../../lib/infrastructure/bus'
require_relative '../../../lib/infrastructure/event_descriptor'

class ReceiveThis

end

class DoNotHandle

end

class SomethingHappened

end


class Handler
  attr_reader :command
  attr_reader :event
  attr_reader :nr_calls_to_receive_this
  attr_reader :nr_calls_to_something_happened

  def initialize
    @nr_calls_to_receive_this = 0
    @nr_calls_to_something_happened = 0
  end

  def receive_this(cmd)
    @command = cmd
    @nr_calls_to_receive_this = @nr_calls_to_receive_this + 1
  end

  def something_happened(event)
    @event = event
    @nr_calls_to_something_happened = @nr_calls_to_something_happened + 1
  end
end

describe Bus do
  let(:bus) { Bus.new }
  let(:handler) { Handler.new }
  before(:each) { bus.register_handler(handler) }

  describe 'send_cmd' do
    let(:cmd) { ReceiveThis.new }

    it 'forwards command to handler' do
      bus.send_cmd(cmd)
      expect(handler.command).to eq(cmd)
    end

    it 'forwards command once' do
      bus.send_cmd(cmd)
      expect(handler.nr_calls_to_receive_this).to eq(1)
    end

    it "ignores handler that don't handle command" do
      cmd = DoNotHandle.new
      expect(lambda { bus.send_cmd(cmd) }).to_not raise_exception
    end
  end

  describe 'publish' do
    let(:evt) { EventDescriptor.new(3, SomethingHappened.new) }

    it 'forwards events to handler' do
      bus.send_event(evt)
      expect(handler.event).to eq(evt)
    end

    it 'forwards event once' do
      bus.send_event(evt)
      expect(handler.nr_calls_to_something_happened).to eq(1)
    end

    it "ignores handler that don't handle event" do
      cmd = DoNotHandle.new
      expect(lambda { bus.send_event(evt) }).to_not raise_exception
    end
  end

end