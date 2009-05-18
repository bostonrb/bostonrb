require File.dirname(__FILE__) + '/../test_helper'

class TweetTest < ActiveSupport::TestCase
  should "be valid with factory" do
    assert_valid Factory.build(:tweet)
  end
  should_belong_to :user
  should_have_index :user_id
end
