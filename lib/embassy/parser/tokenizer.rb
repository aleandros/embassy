# Handle the transformation
# of a raw ruby hash into
# a group of tokens.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    class Tokenizer
      attr_reader :tokens

      def initialize config, root=nil
        @tokens = []
        @root = root

        config.each do |k, v|
          @tokens << Token.new(k, v, root)
        end

        validate_top_level!
      end

      private
        def validate_top_level!
          invalid = @root.nil? && @tokens.any? do |t|
              !t.is_route?
          end
          raise 'Invalid top level' if invalid
        end
    end
  end
end
