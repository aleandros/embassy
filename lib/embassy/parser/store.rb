# Handle storing of the
# resulting routes.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    # Represents the storage collections
    # that ultimately contains the final
    # configuration to be fed to other modules
    # of the program.
    #
    # ===== Attributes
    #
    # * +routes+ - The final output of this module,
    #   which is a hash containing the mapping from routes
    #   to the data they're associated with.
    class Store
      attr_reader :routes

      # Create new instance of the store,
      # setting up an empty collection.
      def initialize
        @routes = {}
      end

      # Append a received token to the collection.
      # Note, however, that each route can have many
      # inputs associated. This is because each route
      # with an associated metadata is a different token.
      # This method handles that logic.
      #
      # ===== Arguments
      #
      # * +token+ -  The token representing and endpoint
      #   por the route.
      def <<(token)
        route, field, data = token.as_result

        if @routes.key? route
          @routes[route][field] = data
        else
          @routes[route] = field == :body ? data : { field => data }
        end
      end
    end
  end
end
