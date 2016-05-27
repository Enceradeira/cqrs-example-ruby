class Repository
  private
  def initialize(storage)
    @storage = storage
  end

  public
  def save(aggregate, expected_version)
    @storage.save_events(aggregate.id, aggregate.uncommitted_changes, expected_version)
  end
end