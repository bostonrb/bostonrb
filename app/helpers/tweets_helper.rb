module TweetsHelper
  def link_to_tweet(tweet)
    name = html_escape(tweet.user.twitter)
    text = html_escape(tweet.text)
    link = link_to(name, "http://twitter.com/#{name}")
    "#{link} &ndash; #{tweet_format(text)}"
  end

  def tweet_format(text)
    linked_text = auto_link(text)
    linked_text.gsub(/@([\w\d_]+)/) do |match|
      %Q{<a href="http://twitter.com/#{$1}">@#{$1}</a>}
    end
  end
end
