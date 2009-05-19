require File.dirname(__FILE__) + '/../test_helper'

class TweetTest < ActiveSupport::TestCase
  should "be valid with factory" do
    assert_valid Factory.build(:tweet)
  end
  should_belong_to  :user
  should_have_index :user_id
  should_validate_presence_of :text, :id, :tweeted_at, :user_id
end
