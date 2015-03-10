# Encapsulate the logic for parsing the YAML file
# that describes the API.
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com
require 'yaml'

module Embassy
  class Parser
    attr_reader :configuration

    def initialize string
      data = YAML.load string
      raise 'Parsed value is not an object' unless data.class == Hash
      @configuration = traverse data
    end

    private
    def traverse data
      routes = {}
      helper = lambda do |obj, route|
        obj.each do |k, v|
          r = route + k
          if v.is_a? Hash
            helper[v, r]
          else
            routes[r] = v
          end
        end
        routes
      end
      helper[data, '']
    end
  end
end
