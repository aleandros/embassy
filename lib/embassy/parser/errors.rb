# Errors for the parser
# namespace.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

module Embassy
  module Parser
    # Base, generic error for the Parser
    # namespace.
    class ParserError < StandardError
    end

    # Error for indicating malformed input data,
    # as received from the raw input string
    # that is used for creating the configuration.
    class MalformedInputError < ParserError
    end

    # This error should be raised whenever the
    # type given encountered at some point
    # during parsing is inconsistent with
    # the one expected given the current context.
    class UnexpectedTypeError < ParserError
    end
  end
end
