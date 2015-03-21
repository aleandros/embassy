# Examples of given YAML strings
# with their corresponding output dictionaries
# (or errors) and the fixture description
#
# Edgar Cabrera, 2015
# edgar@cafeinacode.com

def configuration_fixtures
  {
    'can create a single route' => {
      input: %q{
        /api:
          /resource:
            1
      },
      output: {
        '/api/resource' => 1
      }
    },
    'can create multiple nested routes' => {
      input: %q{
        /entry_1:
          /resource_a:
            1
          /resource_b:
            /nested_a:
              2
            /nested_b:
              3
        /entry_2:
          /resource_c:
            4
      },
      output: {
        '/entry_1/resource_a' => 1,
        '/entry_1/resource_b/nested_a' => 2,
        '/entry_1/resource_b/nested_b' => 3,
        '/entry_2/resource_c' => 4
      }
    }
  }
end
