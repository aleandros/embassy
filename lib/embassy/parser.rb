# Encapsulate the logic for parsing the YAML file
# that describes the API.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require 'yaml'
require_relative 'parser/token'
require_relative 'parser/tokenizer'
require_relative 'parser/store'

module Embassy
  module Parser
    class Parser
      attr_reader :configuration

      def initialize string
        data = YAML.load string
        validate! data

        @tokens = Tokenizer.new(data).tokens

        store = Store.new
        Traverser.new store, @tokens
        @configuration = store.routes
      end

      private
        def validate! data
          raise 'Parsed value is not an object' unless data.class == Hash
        end

        def traverse data
          routes = {}
          helper = lambda do |obj, route|
            obj.each do |k, v|
              r = route + k
              if v.is_a? Hash
                helper[v, r]
              else
                routes[r] = v
              end
            end
            routes
          end
          helper[data, '']
        end
    end
  end
end
