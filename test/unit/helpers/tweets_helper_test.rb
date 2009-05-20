require 'test_helper'

class TweetsHelperTest < ActionView::TestCase
  context "link_to_tweet" do
    setup do
      user   = Factory(:user, :twitter => "Croaky")
      @tweet = Factory(:tweet, :user => user)
      @link  = link_to_tweet(@tweet)
    end

    should "be user's name and tweet" do
      link     = link_to(@tweet.user.twitter,
                         "http://twitter.com/#{@tweet.user.twitter}")
      expected = "#{link} &ndash; #{@tweet.text}"
      assert_equal expected, @link
    end
  end
end

