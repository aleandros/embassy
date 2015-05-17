# Encapsulate the logic for
# converting the loaded configuration
# into an HTTP server.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require 'sinatra/base'
require 'sinatra/contrib'
require_relative 'server/response_creator'
require_relative 'server/route_postprocessor'

module Embassy
  # Namespace for classes related to
  # running a server based on the configuration.
  module Server
    # The Server class is a sinatra
    # application (modular-style)
    # which plays the role of simulating
    # an specification for an API.
    class Server < Sinatra::Application
      # Setup the routes given the configuration
      # received.
      #
      # ===== Parameters
      #
      # * +configuration+ - A dictionary containing the server
      #   configurations, in the form of route => data.
      def self.routes!(configuration)
        configuration.each do |route, value|
          get RoutePostProcessor.new(route).processed_route,
              &ResponseCreator.new(value).response
        end
      end
    end
  end
end
