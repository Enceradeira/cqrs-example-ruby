require 'active_support/all'
require_relative 'events'

class Person
  attr_reader :id

  private
  def initialize(values_or_events)
    @changes = []
    if values_or_events.class == Hash
      # create initialization event
      id = values_or_events[:id]
      name = values_or_events[:name]
      apply_change_and_save(PersonRegistered.new(id, name))
    else
      # restore state of object with events
      values_or_events.each { |event| apply(event) }
    end
  end

  def apply(event)
    apply_method = "apply_#{event.class.name.underscore.to_sym}"
    self.send(apply_method, event) if self.respond_to?(apply_method, :include_private)
  end

  def apply_person_registered(event)
    raise StandardError "id can't be changed" unless @id.nil?
    @id = event.person_id
  end

  def apply_change_and_save(event)
    apply(event)
    @changes << event
  end

  public
  def change_name(new_name)
    apply_change_and_save(NameChanged.new(id, new_name))
  end

  def deregister
    apply_change_and_save(PersonDeregistered.new(id))
  end

  def uncommitted_changes
    @changes
  end

end