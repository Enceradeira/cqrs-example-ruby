class CommandBackup
  private
  def initialize
    @commands = []
  end

  def method_missing(m, *args, &block)
    raise StandardError.new('method is a generic command handler and expects exactly one arg') if args.length != 1
    @commands << args[0]
  end

  public
  def commands
    @commands.clone
  end

  def respond_to?(m)
    true
  end
end