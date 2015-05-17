# Logic for postprocessing
# routes with extra meaning.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Server
    # Contains the logic for postprocessing
    # special directives included in the routes.
    #
    # Directives, or wildcards, are sections
    # of the routes contained within < and >.
    #
    # A wildcard, if defined, is associated with
    # a regular expression to be used by the route.
    #
    # For knowing more aboute regular expressions
    # in routes, check the +Sinatra+ documentation.
    class RoutePostProcessor
      # Constant for holding the defined valid
      # wildcards and their associated regular
      # expressions.
      ROUTE_WILDCARDS = {
        '<number>' => '[\d]+',
        '<alphanumeric>' => '[\w]+'
      }

      # Create the RoutePostProcessor instance.
      #
      # ===== Arguments
      #
      # * +route+ - the original route as specified
      #   in the configuration.
      def initialize(route)
        @original_route = route
      end

      # Returns the route, untouched, if no wildcard
      # was specified, or as a +Regexp+ that can
      # be used as a valid Sinatra Route.
      def processed_route
        return @original_route unless any_wildcard?
        as_regex
      end

      private

      # Returns an +Array+ containg each part
      # of the route (divided by slashes).
      def split
        @original_route.split('/')[1..-1]
      end

      # Indicates if there is at least a wildcard
      # in the route.
      def any_wildcard?
        split.any? do |element|
          wildcard? element
        end
      end

      # Indicates if the given portion of a route
      # is a valid wildcard.
      def wildcard?(element)
        ROUTE_WILDCARDS.key? element
      end

      # Replace the element in the route section
      # if it is a valid wildcard, or return
      # the original unchanged.
      def replace(element)
        if wildcard? element
          ROUTE_WILDCARDS[element]
        else
          element
        end
      end

      # Return the current route as a regular
      # expression, replacing the wildcards
      # as required.
      def as_regex
        Regexp.new('/' + split.map do |element|
          replace element
        end.join('/'))
      end
    end
  end
end
