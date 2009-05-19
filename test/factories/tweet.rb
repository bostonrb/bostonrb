Factory.define :tweet do |tweet|
  tweet.text       { 'string' }
  tweet.twitter_id { 1 }
  tweet.tweeted_at { 5.minutes.ago }
  tweet.association(:user)
end
