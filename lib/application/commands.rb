module Application
  RegisterPerson = Struct.new(:person_id, :name)
  DeregisterPerson = Struct.new(:person_id, :original_version)
  ChangePersonName = Struct.new(:person_id, :new_name, :original_version)
end
