class Repository
  private
  def initialize(storage)
    @storge = storage
  end

  public
  def save(aggregate, expected_version)
    @storge.save_events(aggregate.id, aggregate.uncommitted_changes, expected_version)
  end
end