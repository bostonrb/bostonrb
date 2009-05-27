require 'test_helper'

class TweetsHelperTest < ActionView::TestCase
  context "link_to_tweet" do
    setup do
      user   = Factory(:user, :twitter => "Croaky")
      @tweet = Factory(:tweet, :user => user, :text => 'zomg guys')
      stubs(:tweet_format).returns("FORMATTED TWEET")

      @link  = link_to_tweet(@tweet)
    end

    should "be user's name and formatted tweet" do
      link     = link_to(@tweet.user.twitter,
                         "http://twitter.com/#{@tweet.user.twitter}")
      expected = "#{link} &ndash; FORMATTED TWEET"
      assert_equal expected, @link
    end

    should "call tweet_format with tweet's text" do
      assert_received(self, :tweet_format) {|expect| expect.with('zomg guys') }
    end
  end
  
  context "tweet_format" do
    should "convert @ replies to links" do
      text = "@techpickles lol, totally"
      expected = %Q{<a href="http://twitter.com/techpickles">@techpickles</a> lol, totally}
      assert_equal expected, tweet_format(text)
    end

    should "autolink URLs" do
      text = "http://technicalpickles.com"
      expected = %Q{<a href="http://technicalpickles.com">http://technicalpickles.com</a>}
      assert_equal expected, tweet_format(text)
    end

  end
end

