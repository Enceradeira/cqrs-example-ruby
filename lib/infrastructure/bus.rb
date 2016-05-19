require 'active_support/all'

class Bus
  private
  def initialize
    @handlers = []
  end

  public
  def register_handler(handler)
    @handlers << handler
  end

  def send_cmd(cmd)
    @handlers.each do |h|
      method_name = cmd.class.name.underscore.to_sym
      h.send(method_name, cmd) if h.respond_to?(method_name)
    end
  end
end