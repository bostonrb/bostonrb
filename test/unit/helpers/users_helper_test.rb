require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  context "collage of users" do
    context "when the user's to_s returns nil" do
      setup do
        @users   = [Factory.stub(:user, :gravatar_url => "http://p.ng")]
        @users.first.stubs(:main_url).returns('http://foo.bar')
        @users.first.stubs(:has_link?).returns(true)
        @users.first.stubs(:to_s).returns(nil)
        @collage = collage_of(@users)
      end

      should "be images, without title, based on gravatar URLs of users" do
        expected = [link_to( image_tag("http://p.ng"), 'http://foo.bar' )]
        assert_equal expected, @collage
      end

    end
    context "when the user doesn't have a main_url" do
      setup do
        @users   = [Factory.stub(:user, :gravatar_url => "http://p.ng")]
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
        @users   = [Factory.stub(:user, :gravatar_url => "http://p.ng")]
        @users.first.stubs(:main_url).returns('http://foo.bar')
        @users.first.stubs(:has_link?).returns(true)
        @users.first.stubs(:to_s).returns('foo')
        @collage = collage_of(@users)
      end

      should "be images, without links, based on gravatar URLs of users" do
        expected = [link_to( image_tag("http://p.ng", :title => 'foo'), 'http://foo.bar' )]
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
end

