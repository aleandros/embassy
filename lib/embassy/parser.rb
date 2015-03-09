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
      @configuration = YAML.load string
    end
  end
end
