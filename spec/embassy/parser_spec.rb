# Test the parser.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require_relative '../spec_helper.rb'

PARSER_NS    = Embassy::Parser
PARSER_CLASS = PARSER_NS::Parser

describe PARSER_CLASS do
  describe 'public interface' do
    subject { PARSER_CLASS.new '/hola: adios' }

    it 'has a public configuration property' do
      subject.must_respond_to :configuration
    end
  end

  describe '#initialize' do
    it 'raises exception with invalid YAML' do
      err = proc { PARSER_CLASS.new '%%' }.must_raise PARSER_NS::MalformedInputError
      err.message.must_match(/malformed input/i)
    end

    it 'raises exception if any top level value is not a route' do
      err = proc { PARSER_CLASS.new 'hi: 1' }.must_raise PARSER_NS::UnexpectedTypeError
      err.message.must_match(/non-route at toplevel/i)
    end

    it 'raises exception if parsed YAML is not an object' do
      err = proc { PARSER_CLASS.new 'hi' }.must_raise PARSER_NS::UnexpectedTypeError
      err.message.must_match(/hash[\s\w]+expected/i)
    end
  end

  describe '#configuration' do
    it 'is a hash' do
      PARSER_CLASS.new(configuration_fixtures['can create a single route'][:input])
        .configuration.must_be_instance_of Hash
    end

    configuration_fixtures.each do |name, fixture|
      it name do
        if fixture[:output].class == Class
          proc { PARSER_CLASS.new fixture[:input] }.must_raise fixture[:output]
        else
          PARSER_CLASS.new(fixture[:input]).configuration.must_equal fixture[:output]
        end
      end
    end
  end
end
