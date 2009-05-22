class User < ActiveRecord::Base
  include Clearance::User
  include Pacecar

  is_gravtastic

  has_many :presentations
  has_many :tweets

  attr_accessible :twitter

  def to_s
    twitter
  end

  #For now, the twitter url.
  #If users will have blogs, we could use that instead,
  #and fall back to twitter otherwise.
  def main_url
    return nil unless twitter
    "http://twitter.com/#{twitter.downcase}"
  end

  def has_link?
    !!main_url
  end
end
