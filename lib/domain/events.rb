module Domain
  PersonRegistered = Struct.new(:person_id, :name)
  PersonDeregistered = Struct.new(:person_id)
  NameChanged = Struct.new(:person_id, :new_name)
end