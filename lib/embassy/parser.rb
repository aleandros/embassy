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
require_relative 'parser/errors'

module Embassy
  # Namespace for the logic of creating
  # a route configuration Hash from a tree-like
  # string (which at this point is just YAML).
  #
  # This module also provides the first
  # level of validation for the input data,
  # like correctly formed routes.
  module Parser
    # The Parser class glues together the work
    # of converting a final route configuration
    # hash from the input data, which is
    # a raw string specifying the API.
    class Parser
      # Attribute that represents the configuration hash.
      attr_reader :configuration

      # Create the Parser instance,
      # ensuring that the input data is valid
      # and making the configuration accessible.
      #
      # ===== Paramters
      #
      # * +string+ - The raw string to be used for the configuration.
      def initialize(string)
        data = YAML.load string
        validate! data

        tokens = Tokenizer.new(data).tokens

        store = Store.new
        Traverser.new store, tokens
        @configuration = store.routes
      rescue Psych::SyntaxError
        raise MalformedInputError, 'Malformed input string'
      end

      private

      # Validate the input data after it has received
      # the first level of parsing, (that is, after have been
      # converted into a Hah by the appropriate class.
      def validate!(data)
        fail UnexpectedTypeError, 'A Hash was expected' unless data.is_a? Hash
      end
    end
  end
end
