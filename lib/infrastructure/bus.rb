require_relative '../common/class'

module Infrastructure
  class Bus
    private
    def initialize
      @handlers = []
    end

    def dispatch(cmd, method_name)
      @handlers.each do |h|
        h.send(method_name, cmd) if h.respond_to?(method_name)
      end
    end

    public
    def register_handler(handler)
      @handlers << handler
    end

    def send_cmd(cmd)
      method_name = cmd.class.to_method_name
      dispatch(cmd, method_name)
    end

    def send_event(event)
      method_name = event.event.class.to_method_name
      dispatch(event, method_name)
    end
  end
end