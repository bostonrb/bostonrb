require File.dirname(__FILE__) + '/test_helper.rb'

class Foo < ActiveRecord::Base; end
class CoreExtTest < Test::Unit::TestCase


  def test_random_returns_a_foo_object
    load_schema
    Foo.create!(:foo => 'foo', 
                :bar => 'bar',
                :baz => 'baz')
    assert_kind_of Foo, Foo.random
  end

  def test_random_returns_nil_when_empty_db
    load_schema
    assert_equal nil, Foo.random
  end

  def test_returns_random_foos
    # This is a sufficient test for now. 
    # Fork and help improve it
    load_schema
    randoms = []
    10.times do |n|
      Foo.create!(:foo => "foo#{n}", 
                  :bar => "bar#{n}",
                  :baz => "baz#{n}")
    end

    5.times { randoms << Foo.random }

    assert_block "should be many unique Foos" do
      randoms.uniq.size > 1
    end

  end
end
