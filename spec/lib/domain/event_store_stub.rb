class EventStoreStub
  private
  def initialize
    @events =[]
  end

  public
  def add_event(event)
    @events << event
  end

  def get_events_for_aggregate(id)
    @events
  end
end