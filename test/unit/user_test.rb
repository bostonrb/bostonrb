require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "respond to is_gravtastic" do
    user = Factory(:user, :email => 'john@doe.com')
    assert_respond_to user, :gravatar_url
  end

  context "an user" do
    setup do
      @user = Factory(:user, :twitter => "Croaky")
    end

    should_have_many :tweets
    should_allow_mass_assignment_of :twitter

    should "display twitter name as string representation" do
      assert_equal "Croaky", @user.to_s
    end
  end
end
