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
        lambda do
          body
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
          end.to_s
        end
    end
  end
end
