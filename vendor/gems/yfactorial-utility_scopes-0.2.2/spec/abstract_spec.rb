require File.join(File.dirname(__FILE__), *%w[spec_helper])
require 'activerecord'

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'utility_scopes'

# Load a test class
def uses_fixture(fixture_name)
  require File.join(File.dirname(__FILE__), 'fixtures', fixture_name.to_s)
end