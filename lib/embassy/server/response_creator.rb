# Encapsulate the logic for
# generating a response given
# the data associated to a route.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Server
    class ResponseCreator
      def initialize data
        @data = data
      end

      def response
        body = get_body
        status = get_status
        lambda do
          status status
          json body
        end
      end

      private
        def has_meta?
          return false unless @data.is_a? Hash
          @data.keys.any? { |k| k.is_a? Symbol }
        end

        def get_body
          if has_meta?
            @data[:body]
          else
            @data
          end
        end

        def get_status
          if has_meta?
            @data[:status]
          else
            200
          end
        end
    end
  end
end
