# Test the parser.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require_relative '../spec_helper.rb'

describe Embassy::Parser do
  describe 'public interface' do
    subject { Embassy::Parser.new 'hola: adios' }

    it 'has a public configuration property' do
      subject.must_respond_to :configuration
    end
  end

  describe '#initialize' do
    it 'raises exception with invalid YAML' do
      proc { Embassy::Parser.new '%%' }.must_raise Psych::SyntaxError
    end

    it 'raises exception if parsed YAML is not an object' do
      proc { Embassy::Parser.new 'hi' }.must_raise RuntimeError
    end
  end

  describe '#configuration' do
    it 'is a hash' do
      Embassy::Parser.new(configuration_fixtures['can create a single route'][:input])
        .configuration.must_be_instance_of Hash
    end

    configuration_fixtures.each do |name, fixture|
      it name do
        if fixture[:output].class == Class
          proc { Embassy::Parser.new fixture[:input] }.must_raise fixture[:output]
        else
          Embassy::Parser.new(fixture[:input]).configuration.must_equal fixture[:output]
        end
      end
    end
  end
end
