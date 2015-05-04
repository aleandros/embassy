# Representation of a parsed token.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    class Token
      attr_reader :key, :value, :parent

      def initialize key, value, parent
        @key = key
        @value = value
        @parent = parent
      end

      def is_route?
        @key.start_with? '/'
      end

      def is_data?
        @key == 'returns'
      end

      def has_next_token?
        @value.is_a? Hash
      end

      def as_result
        if is_data?
          [@parent, @value]
        else
          [as_parent, @value]
        end
      end

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
