# Handle the transformation
# of a raw ruby hash into
# a group of tokens.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    # Class that given a raw hash,
    # creates a collection of tokens.
    #
    # This process is shallow; wether the
    # current tokens can be further
    # traversed is a logic that does
    # not belong to this class.
    #
    # ===== Attributes
    #
    # * +tokens+ - An +Array+ of +Token+ instances,
    #   representing the topmost level of the
    #   input tree.
    class Tokenizer
      # Read-only attribute, as described above.
      attr_reader :tokens

      # Create instance of tokenizer, making the
      # +#tokens+ accessible for the client.
      #
      # Some validation is done at this stage
      # for enforcing certain strcture in the data.
      #
      # ===== Arguments
      #
      # * +config+ - A hash containing the raw input,
      #   for which each key is transformed into
      #   an instance of +Token+.
      # * +root+ - The parent of the topmost level
      #   for each of the +#tokens+. It is +nil+
      #   by default.
      def initialize(config, root = nil)
        @tokens = []
        @root = root

        config.each do |k, v|
          @tokens << Token.new(k, v, root)
        end

        validate_top_level!
        validate_group!
      end

      private

      # Validate that if no parent is present (the topmost
      # level of the configuration) then all tokens
      # must represent routes.
      def validate_top_level!
        invalid = @root.nil? && @tokens.any? do |t|
          !t.route?
        end
        fail 'Invalid top level' if invalid
      end

      # Validate that the +#tokens+ do not combine
      # routes and metadata with raw objects at the
      # same level.
      def validate_group!
        has_normal = @tokens.any? do |t|
          t.route? || t.meta?
        end

        has_raw = @tokens.any? do |t|
          !t.route? && !t.meta?
        end

        fail 'Invalid object combination' if has_raw && has_normal
      end
    end
  end
end
