# Logic for postprocessing
# routes with extra meaning.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Server
    class RoutePostProcessor
      def initialize route
        @original_route = route
      end

      def processed_route
        return @original_route unless has_wildcard?
        as_regex
      end

      private
        def split
          @original_route.split('/')[1..-1]
        end

        def has_wildcard?
          split.any? do |element|
            is_wildcard? element
          end
        end

        def is_wildcard? element
          ROUTE_WILDCARDS.has_key? element
        end

        def process element
          if is_wildcard? element
            replace element
          else
            element
          end
        end

        def replace element
          if is_wildcard? element
            ROUTE_WILDCARDS[element]
          else
            element
          end
        end

        def as_regex
          Regexp.new('/' + split.map do |element|
            replace element
          end.join('/'))
        end
    end

    ROUTE_WILDCARDS = {
      '<number>' => '[\d]+',
      '<alphanumeric>' => '[\w]+'
    }
  end
end
