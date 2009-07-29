require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  context "collage of users" do
    context "when the user's to_s returns nil" do
      setup do
        @users   = [Factory.stub(:user)]
        @users.first.stubs(:gravatar_url).returns("http://p.ng")
        @users.first.stubs(:main_url).returns('http://foo.bar')
        @users.first.stubs(:has_link?).returns(true)
        @users.first.stubs(:to_s).returns(nil)
        @collage = collage_of(@users)
      end

      should "be images, without title, based on gravatar URLs of users" do
        expected = [link_to( image_tag("http://p.ng"), 'http://foo.bar', :target => '_blank')]
        assert_equal expected, @collage
      end

    end
    context "when the user doesn't have a main_url" do
      setup do
        @users   = [Factory.stub(:user)]
        @users.first.stubs(:gravatar_url).returns("http://p.ng")
        @users.first.stubs(:main_url).returns(nil)
        @users.first.stubs(:has_link?).returns(false)
        @users.first.stubs(:to_s).returns(nil)
        @collage = collage_of(@users)
      end

      should "be images, without links, based on gravatar URLs of users" do
        expected = [image_tag("http://p.ng")]
        assert_equal expected, @collage
      end
    end
    context 'when the user has a main_url' do
      setup do
        @users   = [Factory.stub(:user)]
        @users.first.stubs(:gravatar_url).returns("http://p.ng")
        @users.first.stubs(:main_url).returns('http://foo.bar')
        @users.first.stubs(:has_link?).returns(true)
        @users.first.stubs(:to_s).returns('foo')
        @collage = collage_of(@users)
      end

      should "be images, without links, based on gravatar URLs of users" do
        expected = [link_to( image_tag("http://p.ng", :title => 'foo'), 'http://foo.bar', :target => '_blank')]
        assert_equal expected, @collage
      end

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

  context "setup_user" do
    should "return the user" do
      user = Factory.build(:user)

      assert_same user, setup_user(user)
    end

    should "build feed if it doesn't exist" do
      user = Factory.build(:user)

      setup_user(user)

      assert_not_nil user.feed
    end

    should "keep original feed if it is present" do
      feed = Factory.build(:feed)
      user = Factory.build(:user, :feed => feed)

      setup_user(user)

      assert_same feed, user.feed
    end

  end
end

