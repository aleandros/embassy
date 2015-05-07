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
    it 'returns the value given the configuration' do
      app.set_routes!({'/route' => 1})
      get '/route'
      last_response.body.must_equal '1'
    end

    it 'correctly handles a body specification' do
      app.set_routes!({'/route' => {body: 'hello'}})
      get '/route'
      last_response.body.must_equal 'hello'
    end

    it 'returns an OK status by default' do
      app.set_routes!({'/route' => 1})
      get '/route'
      last_response.must_be :ok?
    end
  end

  after do
    app.reset!
  end
end
