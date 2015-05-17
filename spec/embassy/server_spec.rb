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
      app.routes!({'/route' => 1})
      get '/route'
      last_response.body.must_equal '1'
    end

    it 'correctly handles a body specification' do
      app.routes!({'/route' => {body: 'hello'}})
      get '/route'
      last_response.body.must_equal 'hello'.to_json
    end

    it 'returns an OK status by default' do
      app.routes!({'/route' => 1})
      get '/route'
      last_response.must_be :ok?
    end

    it 'returns the specific status code when provided' do
      app.routes!({'/route' => {body: 1, status: 301}})
      get '/route'
      last_response.status.must_equal 301
    end

    it 'uses json as the return format' do
      hash = {'a' => 1, 'b' => 2}
      app.routes!({'/route' => hash})
      get '/route'
      last_response.body.must_equal hash.to_json
    end

    it 'uses json for returning arrays too' do
      arr = [1, 2, 3, 4]
      app.routes!({'/route' => arr})
      get '/route'
      last_response.body.must_equal arr.to_json
    end
  end

  describe 'with wildcards in routes' do
    it 'accepts any number in route where specified' do
      app.routes!({'/route/<number>' => 1 })
      get '/route/1042'
      last_response.must_be :ok?
    end

    it 'fails if passed a non-number for the number specification' do
      app.routes!({'/route/<number>' => 1 })
      get '/route/a1042'
      last_response.wont_be :ok?
    end

    it 'accepts an alphanumeric string in route where specified' do
      app.routes!({'/route/<alphanumeric>' => 1 })
      get '/route/ab1234'
      last_response.must_be :ok?
    end
  end

  after do
    app.reset!
  end
end
