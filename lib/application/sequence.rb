class Sequence
  class << self
    def next
      @last ||= 0
      @last = @last + 1
    end
  end
end