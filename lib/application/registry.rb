module Application
  class Registry
    class << Registry
      def method_missing(method, *arguments, &block)
        variables = method.to_s.scan(/register_(.+)/)
        if variables.length == 1 && variables[0].length == 1 && arguments.length == 1
          # @database = arguments[0]
          eval("@#{variables[0][0]} = arguments[0]")
          true
        elsif arguments.length == 0
          eval("@#{method}")
        else
          super
        end
      end
    end
  end
end
