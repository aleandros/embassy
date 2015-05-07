# Test the server.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require_relative '../spec_helper.rb'
require 'json'

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
      last_response.body.must_equal 'hello'.to_json
    end

    it 'returns an OK status by default' do
      app.set_routes!({'/route' => 1})
      get '/route'
      last_response.must_be :ok?
    end

    it 'returns the specific status code when provided' do
      app.set_routes!({'/route' => {body: 1, status: 301}})
      get '/route'
      last_response.status.must_equal 301
    end

    it 'uses json as the return format' do
      hash = {'a' => 1, 'b' => 2}
      app.set_routes!({'/route' => hash})
      get '/route'
      last_response.body.must_equal hash.to_json
    end

    it 'uses json for returning arrays too' do
      arr = [1, 2, 3, 4]
      app.set_routes!({'/route' => arr})
      get '/route'
      last_response.body.must_equal arr.to_json
    end
  end

  after do
    app.reset!
  end
end
