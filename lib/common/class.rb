require 'active_support/all'

class Class
  def to_method_name
    module_method_name = self.name.underscore
    module_method_name.split('/').last
  end
end
