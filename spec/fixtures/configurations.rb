# Examples of given YAML strings
# with their corresponding output dictionaries
# (or errors) and the fixture description
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

def basic_example
  {
    input: %q{
      /api:
        /resource:
          1
    },
    output: {
      '/api/resource' => 1
    }
  }
end
