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

  context "collage_div_attributes" do
    should "include the an id based on the index" do
      assert_equal "collage_group_1", collage_div_attributes(1)[:id]
    end

    should "not specify a class for the first index" do
      assert_nil collage_div_attributes(0)[:class]
    end

    should "include a hidden class for other indexes" do
      assert_equal "hidden", collage_div_attributes(1)[:class]
    end
  end
end

