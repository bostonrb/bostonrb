require 'test_helper'

class PresentationsHelperTest < ActionView::TestCase
  context 'calling parse_presenter' do
    setup do
      @presentation = Factory(:presentation)
    end

    context 'when the presenter is a user' do
      context 'when the user has a twitter' do
        setup do
          @user = User.new(:twitter => 'foo')
          @presentation.stubs(:presenter).returns(@user)
        end

        should "return the users's twitter name" do
          assert_equal 'foo', parse_presenter(@presentation)
        end
      end
      context 'when the user does not have a twitter' do
        setup do
          @user = User.new(:twitter => nil, :email => 'foo@bar.baz')
          @presentation.stubs(:presenter).returns(@user)
        end

        should "return the users's twitter name" do
          assert_equal 'foo@bar.baz', parse_presenter(@presentation)
        end
      end
    end

    context 'when the presenter is a string' do
      setup do
        @presentation.stubs(:presenter).returns('bar')
      end

      should 'return the string' do
        assert_equal 'bar', parse_presenter(@presentation)
      end
    end

  end

end

