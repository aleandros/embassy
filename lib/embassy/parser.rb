# Encapsulate the logic for parsing the YAML file
# that describes the API.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require 'yaml'
require_relative 'parser/token'
require_relative 'parser/tokenizer'
require_relative 'parser/store'
require_relative 'parser/traverser'

module Embassy
  module Parser
    class Parser
      attr_reader :configuration

      def initialize string
        data = YAML.load string
        validate! data

        tokens = Tokenizer.new(data).tokens

        store = Store.new
        Traverser.new store, tokens
        @configuration = store.routes
      end

      private
        def validate! data
          raise 'Parsed value is not an object' unless data.class == Hash
        end
    end
  end
end
