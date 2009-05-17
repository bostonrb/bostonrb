require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "respond to is_gravtastic" do
    user = Factory(:user, :email => 'john@doe.com')
    assert_respond_to user, :gravatar_url
  end
end
