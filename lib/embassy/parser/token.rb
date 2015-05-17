# Representation of a parsed token.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    # Represents a unit of inspectable information
    # from the input hash data.
    #
    # This class works mainly as a container
    # for helping the traversing and validation
    # of the input structure so the final
    # configuation can be created.
    #
    # ===== Attributes
    #
    # * +key+ - Represents the associated key of
    #   the Token. Its value defines what it
    #   represents in the route configuration.
    # * +value+ - The data associated to the key.
    # * +parent+ - Since the input data is a tree-like
    #   structure, this works for keeping a reference to
    #   the parent object. The parent is NOT a token,
    #   but instead is the +key+ of the last token. It can
    #   be nil. It is usefule for generating the final, total
    #   route from nested input.
    class Token
      # Read-only attributes as described above.
      attr_reader :key, :value, :parent

      # Create an instance of the token.
      #
      # ===== Parameters
      #
      # * +key+ - The value to be associated with the
      #   token.
      # * +value+ - The value associated to the +key+.
      # * +parent+ - A reference to the parent. It is only
      #   a string. The rules of its formation can be
      #   seen in the +#as_parent+ method.
      def initialize(key, value, parent)
        @key = key
        @value = value
        @parent = parent
      end

      # Checks if the token represents a route.
      #
      # This is simply defined as the +#key+ starting with a slash.
      def route?
        @key.start_with? '/'
      end

      # Checks if the route represents medatada. Metadata
      #
      # is useful for creating richer behavior for a route.
      # The result depends on the +#key+ starting with $.
      def meta?
        @key.start_with? '$'
      end

      # Checks if the token has more tokens nested.
      #
      # Internally, this means that the value of the token is a +Hash+
      # that must be traversed further, but wether this is done
      # or not, ultimately depends on the meaning given to the token
      # by the rest of its properties.
      def next_token?
        @value.is_a? Hash
      end

      # Represents the token as a result to be used for the
      # final configuration object. There can be two types of
      # outcomes, depending on wether the Token represents metadata
      # or not.
      #
      # ===== Returns
      #
      # An +Array+ containing:
      #
      # * The parent, if the route is true for +#meta?+, or the token
      #   itself as if it were a parent, which is the same as a full route.
      # * A symbol representing the type of data contained in the route.
      #   If none is specified, :body is used. Otherwise, the name of the
      #   metadata itself is used.
      # * The value associated to the output.
      def as_result
        if meta?
          [@parent, @key[1..-1].to_sym, @value]
        else
          [as_parent, :body, @value]
        end
      end

      # Returns the current token representation to be
      # used as a parent for its children.
      #
      # ===== Returns
      #
      # It the token has a parent, then the result is the
      # current parent plus the current key. Otherwise,
      # the key is returned.
      def as_parent
        if @parent
          @parent + @key
        else
          @key
        end
      end
    end
  end
end
