require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "respond to is_gravtastic" do
    user = Factory(:user, :email => 'john@doe.com')
    assert_respond_to user, :gravatar_url
  end

  should_have_many :tweets
  should_allow_mass_assignment_of :twitter
end
