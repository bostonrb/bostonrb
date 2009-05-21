require File.dirname(__FILE__) + '/../test_helper'

class AppTest < ActiveSupport::TestCase
  should "be valid with factory" do
    assert_valid Factory.build(:app)
  end

  should_validate_url_format_of :homepage_url
end
