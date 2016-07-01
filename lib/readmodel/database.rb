module ReadModel
  class Database
    attr_reader :persons

    def initialize
      @persons = []
    end
  end
end