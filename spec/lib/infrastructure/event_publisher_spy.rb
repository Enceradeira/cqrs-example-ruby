class EventPublisherSpy
  private
  def initialize
    @published_events = []
  end

  public
  attr_reader :published_events

  def send_event(event)
    @published_events << event
  end

end