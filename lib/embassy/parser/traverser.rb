# Abstracts the logic of traversing the
# route tree.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    # Class in charge of recursively traversing the
    # input data.
    #
    # This class is NOT in charge of validating the route
    # or properly save it to the final configuration structure.
    #
    # Note that it is also not responsible of splitting the
    # input structructure into a traversable one. It already
    # assumens that an array of instances of the +Token+ class
    # is received.
    class Traverser
      # Create the instance of +Traverser+.
      #
      # Given its inputs, recursively traverses
      # the input data to form an appropriate structure.
      #
      # ===== Arguments
      #
      # * +store+ - An instance of the +Store+ class. It receives
      #   the routes as soon as the leaves of the input tree are
      #   reached. It must be, by definition, mutable, since
      #   the result of the traversing process must be inspected
      #   in this object.
      # * +tokens+ - An already traversable collection of instances
      #   of the +Token+ class. This means that the items of the tree
      #   are already validated on the top level. Subsequent levels
      #   are delegated to a class that can convert hash information
      #   into the next collection of tokens.
      def initialize(store, tokens)
        @store = store
        recurse tokens
      end

      # Method in charge of the recursion logic for
      # traversing the tokens collection.
      #
      # Given its input, if it reaches another tree
      # (which means another level of routing, altough
      # this knowledge is delegated to the token itself),
      # then the function recurses over itself to the next
      # group of tokens with the help of the +Tokenizer+ class.
      #
      # If a leaf is reached, it is appendend to this object's
      # store.
      #
      # ===== Arguments
      #
      # * +tokens+ - A collection of tokens, (from the +Token+ class).
      def recurse(tokens)
        tokens.each do |t|
          if t.route? && t.next_token?
            recurse Tokenizer.new(t.value, t.as_parent).tokens
          else
            @store << t
          end
        end
      end
    end
  end
end
