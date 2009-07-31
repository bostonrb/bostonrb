require File.dirname(__FILE__) + '/../test_helper'

class TweetTest < ActiveSupport::TestCase
  should "be valid with factory" do
    assert_valid Factory.build(:tweet)
  end

  should_belong_to  :user
  should_have_db_index :user_id
  should_validate_presence_of :text, :twitter_id, :tweeted_at, :user_id

  context "recent five Tweets given six existing Tweets" do
    setup do
      6.times { |i| Factory(:tweet, :tweeted_at => i.minutes.ago) }
      @tweets = Tweet.recent(5)
    end

    should "only find five tweets" do
      assert_equal 5, @tweets.to_a.size
    end

    should "order tweets by tweeted at" do
      expected = @tweets.sort_by(&:tweeted_at).reverse
      assert_equal expected, @tweets
    end
  end
end
