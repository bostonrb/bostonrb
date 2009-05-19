class Tweet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :twitter_id, :text, :tweeted_at, :user_id

  def self.recent(number)
    ordered("tweeted_at desc").limited(number)
  end
end
