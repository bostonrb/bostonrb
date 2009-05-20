module TweetsHelper
  def link_to_tweet(tweet)
    name = html_escape(tweet.user.twitter)
    text = html_escape(tweet.text)
    link = link_to(name, "http://twitter.com/#{name}")
    "#{link} &ndash; #{auto_link(text)}"
  end
end
