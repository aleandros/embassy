# Test the parser.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require_relative '../spec_helper.rb'

describe Embassy::Parser do
  let :basic_example do
    %q{
    /api:
      /resource:
        1
    }
  end

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
    subject { Embassy::Parser.new(basic_example).configuration }

    it 'is a hash' do
      subject.must_be_instance_of Hash
    end

    it 'can compose a route' do
      subject.must_equal({'/api/resource' => 1})
    end
  end
end
