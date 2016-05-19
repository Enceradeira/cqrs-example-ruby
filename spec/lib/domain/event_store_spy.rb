require_relative '../../../spec/lib/domain/save_event_arg'

class EventStoreSpy
  private
  def initialize
    @saved_events = []
  end
  public
  attr_reader :saved_events


  def save_events(id, changes, expected_version)
    @saved_events << SaveEventArg.new(id,changes,expected_version)
  end
end