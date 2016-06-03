class CommandStore
  private

  def method_missing(m, *args, &block)
    puts m
  end

  public
  def respond_to?(m)
    puts m
    true
  end


end