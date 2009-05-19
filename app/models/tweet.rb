class Tweet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :twitter_id, :text, :tweeted_at, :user_id
end
