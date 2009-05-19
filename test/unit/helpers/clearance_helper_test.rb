require 'test_helper'

class ClearanceHelperTest < ActionView::TestCase
  should "be sign up & sign in links for signed out links" do
    expected = [link_to("Sign up", sign_up_path),
                link_to("Sign in", sign_in_path)]
    assert_equal expected, signed_out_links
  end

  should "be my account & sign out links for signed in links" do
    user = Factory(:email_confirmed_user)
    self.expects(:current_user).returns(user)
    expected = [link_to("My Account",  edit_user_path(user)),
                link_to("Sign out", sign_out_path)]
    assert_equal expected, signed_in_links
  end
end

