# Encapsulate the logic for
# generating a response given
# the data associated to a route.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Server
    # This class creates a response to be returned
    # by the route. A response is a block that will
    # be passed to the +Sinatra+ route.
    class ResponseCreator
      # Instiantiates the ResponseCreator.
      #
      # ===== Arguments
      #
      # * +data+ - The data associated to a route, as
      #   provided by the route configuration hash.
      def initialize(data)
        @data = data
      end

      # Returns the response associated with
      # the provided input data.
      #
      # ===== Returns
      #
      # A lambda to be passed to the +Server+ class.
      # The lambda returns a json response, and sets
      # the corresponding status (200 by default).
      def response
        response_body = body
        response_status = status
        lambda do
          status response_status
          json response_body
        end
      end

      private

      # Indicates if the provided data is metadata,
      # which helps other methods decide how to
      # handle the input.
      def meta?
        return false unless @data.is_a? Hash
        @data.keys.any? { |k| k.is_a? Symbol }
      end

      # Return the body associated to the response,
      # depending on wether it is a raw value or it
      # is contained in the +:body+ metadata.
      def body
        if meta?
          @data[:body]
        else
          @data
        end
      end

      # Returns the status associated with the response.
      # If not provided, use 200 (HTTP OK) by default.
      def status
        if meta?
          @data[:status]
        else
          200
        end
      end
    end
  end
end
