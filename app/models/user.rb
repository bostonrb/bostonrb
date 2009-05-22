class User < ActiveRecord::Base
  include Clearance::User
  include Pacecar

  is_gravtastic

  has_many :presentations
  has_many :tweets
  has_one  :feed

  accepts_nested_attributes_for :feed, :reject_if => proc { |attrs| attrs.nil? || attrs.all? { |key, value| value.blank? } }

  attr_accessible :twitter
  attr_accessible :feed_attributes

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
