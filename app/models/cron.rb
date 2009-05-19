class Cron
  def self.get_tweets
    client = TwitterSearch::Client.new
    users  = User.twitter_present
    users.each do |user|
      tweets = client.query "from: #{user.twitter}"
      tweets.each do |tweet|
        unless Tweet.find_by_twitter_id(tweet.id)
          user.tweets.create(:text       => tweet.text,
                             :twitter_id => tweet.id,
                             :tweeted_at => tweet.created_at)
        end
      end
    end
  end
end
