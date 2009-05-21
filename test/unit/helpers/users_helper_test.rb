require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  context "collage of users" do
    setup do
      @users   = [Factory.stub(:user, :gravatar_url => "http://p.ng")]
      @collage = collage_of(@users)
    end

    should "be images based on gravatar URLs of users" do
      expected = [image_tag("http://p.ng")]
      assert_equal expected, @collage
    end
  end
end

