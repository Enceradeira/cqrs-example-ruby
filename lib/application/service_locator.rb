class ServiceLocator
  class << self
    def service
      Service.new
    end
  end
end