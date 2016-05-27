RegisterPerson = Struct.new(:person_id, :name)
ChangePersonName = Struct.new(:person_id, :new_name, :original_version)
