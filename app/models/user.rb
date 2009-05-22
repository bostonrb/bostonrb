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

  validates_format_of :twitter, :with => /^[a-zA-Z][a-z0-9A-Z]{1,15}$/, :allow_nil => true
  before_validation :cleanout_twitter


  def to_s
    twitter
  end

  # For now, the twitter url.
  # Eventually we'll just use user_path for gravatar links
  # and this method may just become main_external_url,
  # which may be their blog or their twitter.
  def main_url
    return nil unless twitter
    "http://twitter.com/#{twitter.downcase}"
  end

  def has_link?
    !!main_url
  end

  private

    def cleanout_twitter
      twitter.gsub!(/^@/, '') if twitter
    end

end
