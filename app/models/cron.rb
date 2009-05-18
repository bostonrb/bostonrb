class Cron
  #spike
  def self.get_tweets
    client = TwitterSearch::Client.new
    users  = User.twitter_present
    users.each do |user|
      tweets = client.query "from: #{user.twitter}"
      tweet.each do |tweet|
        unless Tweet.find_by_twitter_id(tweet.id)
          user.tweets.create(:text => tweet.text, :twitter_id => tweet.id)
        end
      end
    end
  end
end
