require File.dirname(__FILE__) + '/test_helper.rb'

class Foo < ActiveRecord::Base; end

class FastRandomTest < Test::Unit::TestCase

  
  def test_schema_has_loaded_correctly
    load_schema 
    assert_equal [], Foo.all
  end

end
