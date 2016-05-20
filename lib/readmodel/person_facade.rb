class PersonFacade
  private
  def initialize(db)
    @db = db
  end
  public
  def get_persons
    @db.persons
  end
end