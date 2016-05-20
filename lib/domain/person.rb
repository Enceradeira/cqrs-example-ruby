require_relative 'person_registered'

class Person
  attr_reader :id

  private
  def initialize(id, name)
    @changes = []
    @id = id
    apply_change(PersonRegistered.new(id, name))
  end

  def apply_change(event)
    apply_change_and_save(event, true)
  end

  def apply_change_and_save(event, is_new)
    #apply(event)
    @changes << event if is_new
  end

  public
  def uncommitted_changes
    @changes
  end

end