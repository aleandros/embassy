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
    },
    'allows non-bottom level routes to return a value' => {
      input: %q{
        /api:
          /resource:
            1
          $body: 2
      },
      output: {
        '/api/resource' => 1,
        '/api' => 2
      }
    },
    'allows the specification of a return status code' => {
      input: %q{
        /api:
          /resource_1: 'result'
          /resource_2:
            $status: 301
            $body: 4
      },
      output: {
        '/api/resource_1' => 'result',
        '/api/resource_2' => {body: 4, status: 301}
      }
    },
    'disallows using raw keys with meta-fields' => {
      input: %q{
        /api:
          $body: 'hello'
          raw: 1
      },
      output: RuntimeError
    },
    'can return an object as a body' => {
      input: %q{
        /api:
          $body:
            a: 1
            b: 2
            c: 3
      },
      output: {
        '/api' => {'a' => 1, 'b' => 2, 'c' => 3}
      }
    },
    'can return an array as body' => {
      input: %q{
        /api:
          $body:
            - 1
            - 2
            - 3
      },
      output: {
        '/api' => [1, 2, 3]
      }
    }
  }
end
