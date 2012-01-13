module FakeTwitter
  def self.included(mod)
    @@fake_tweets    = nil
    @@fake_following = nil
  end

  def follow(someone)
    fake_following << someone
    Rails.logger.debug "FAKETWITTER: following: #{someone}"
  end

  def update(tweet)
    fake_tweets << tweet
    Rails.logger.debug "FAKETWITTER: tweeting: #{tweet}"
  end

  def fake_following
    @@fake_following ||= []
  end
  def fake_tweets
    @@fake_tweets ||= []
  end

  class << self
    def activate!
      Twitter::Client.send :include, self
    end
  end
end
