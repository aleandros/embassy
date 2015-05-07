# Encapsulate the logic for
# converting the loaded configuration
# into an HTTP server.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require 'sinatra/base'
require 'sinatra/contrib'
require_relative 'server/response_creator'

module Embassy
  module Server
    class Server < Sinatra::Application
      def self.set_routes! configuration
        configuration.each do |route, value|
          get route, &ResponseCreator.new(value).response
        end
      end
    end
  end
end
