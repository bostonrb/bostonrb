class Blogger < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  validates :name,     :presence => true
  validates :feed_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i, :message => 'invalid URL' }

  before_create :load_from_feed
  after_create  :tweet_new_blogger
  after_save    :follow_on_twitter

  scope :alphabetically, order(:name)

  def follow_on_twitter
    Twitter.follow(twitter_username) if twitter_username_changed? && !twitter_username.blank?
  end

  def tweet_new_blogger
    Twitter.update("Introducing #{twitter_username} a new Boston Rubyist blogger") unless twitter_username.blank?
  end

  def most_recent_post
    @most_recent_post ||= posts.most_recent(:page=>1, :per=>1).first
  end

  def load_from_feed
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    all_posts = Post.new_from_entries(self, feed.entries)
    update_attributes_from_feed(feed, all_posts)
  end

  def update_from_feed
    feed = Feedzirra::Parser::Atom.new
    feed.feed_url = feed_url
    feed.etag = etag
    if most_recent_post
      last_entry = Feedzirra::Parser::AtomEntry.new
      last_entry.url = most_recent_post.url
      feed.entries = [last_entry]
    end

    Feedzirra::Feed.update(feed)
    if feed.updated?
      new_posts = Post.new_from_entries(self, feed.new_entries)
      update_attributes_from_feed(feed, new_posts)
      save
      new_posts.each(&:tweet)
    end
  end

  def self.update_all_from_feeds
    Blogger.all.each(&:update_from_feed)
  end

  private
  def update_attributes_from_feed(feed, posts)
    self.etag  = feed.etag
    self.title = feed.title
    self.url   = feed.url
    self.posts += posts
  end
end
