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
        route, data = token.as_result
        @routes[route] = data
      end
    end
  end
end
