# Test the server.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require_relative '../spec_helper.rb'

SERVER_CLASS = Embassy::Server::Server
PARSER_CLASS ||= Embassy::Parser::Parser

include Rack::Test::Methods

describe SERVER_CLASS do
  def app
    SERVER_CLASS
  end

  describe 'with single route configuration' do
    before do
      raw = %q{
        /route: 1
      }
      config = PARSER_CLASS.new(raw).configuration
      app.set_routes! config
    end

    it 'returns the value given the configuration' do
      get '/route'
      last_response.body.must_equal '1'
    end
  end
end
