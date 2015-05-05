# Handle storing of the
# resulting routes.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    class Store
      attr_reader :routes

      def initialize
        @routes = {}
      end

      def << token
        route, field, data = token.as_result

        is_body = field == :body
        exists = @routes.has_key? route

        if exists
          @routes[route][field] = data
        else
          if is_body
            @routes[route] = data
          else
            @routes[route] = {field => data}
          end
        end
      end
    end
  end
end
