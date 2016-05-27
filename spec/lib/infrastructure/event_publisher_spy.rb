class EventPublisherSpy
  private
  def initialize
    @published_events = []
  end

  public
  attr_reader :published_events

  def publish(event)
    @published_events << event
  end

end