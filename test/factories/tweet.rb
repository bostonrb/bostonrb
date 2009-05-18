Factory.define :tweet do |tweet|
  tweet.text { 'string' }
  tweet.twitter_id { 1 }
  tweet.association(:user)
end
