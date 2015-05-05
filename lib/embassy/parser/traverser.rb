# Abstracts the logic
# of traversing the
# route tree.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    class Traverser
      def initialize store, tokens
        @store = store
        recurse tokens
      end

      def recurse tokens
        tokens.each do |t|
          if t.is_route? && t.has_next_token?
            recurse Tokenizer.new(t.value, t.as_parent).tokens
          else
            @store << t
          end
        end
      end
    end
  end
end
