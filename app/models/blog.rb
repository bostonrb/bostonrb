class Blog < ActiveRecord::Base
  validates :author,           :presence => true
  validates :twitter_username, :format => { :with => /^@(\w)+$/i, :message => 'invalid twitter username' }
  validates :feed_url,         :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i, :message => 'invalid URL' },
                               :unless => :feed_is_file_url_for_testing?

  before_save :load_from_feed, :if => :new_record?

  scope :alphabetically, order(:author)

  def feed_is_file_url_for_testing?
    feed_url =~ /^file:\/\//
  end

  def load_from_feed
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    update_attributes_from_feed(feed)
    self.most_recent_post_url = most_recent_entry(feed.entries).url
  end

  def update_from_feed
    feed = Feedzirra::Parser::Atom.new
    feed.feed_url = feed_url
    feed.etag     = etag
    if most_recent_post_url
      last_entry     = Feedzirra::Parser::AtomEntry.new
      last_entry.url = most_recent_post_url
      feed.entries   = [last_entry]
    end

    Feedzirra::Feed.update(feed)
    if feed.updated?
      update_attributes_from_feed(feed)
      unless feed.new_entries.empty?
        self.most_recent_post_url = most_recent_entry(feed.new_entries).url
        tweet_entries(feed.new_entries)
      end
      save
    end
  end

  def self.update_all_from_feeds
    Blog.all.each(&:update_from_feed)
  end

  private
  def most_recent_entry(entries)
    @most_recent_entry ||= entries.sort_by(&:published).last
  end
  def update_attributes_from_feed(feed)
    self.etag                 = feed.etag
    self.title                = feed.title
    self.url                  = feed.url
  end

  def tweet_entries(entries)
    entries.each do |entry|
      tweet_entry(entry) if entry.categories.include?('ruby')
    end
  end

  SHORT_URL_LENGTH = 20 # should query as this may change.  See https://dev.twitter.com/docs/tco-link-wrapper/faq#Will_t.co-wrapped_links_always_be_the_same_length
  def tweet_entry(entry)
    tweet = "Boston Rubyist #{twitter_username} just blogged about TITLE_PLACEHOLDER #{entry.url}"
    max_title_length = 140 - (tweet.length - 'TITLE_PLACEHOLDER'.length - entry.url.length + SHORT_URL_LENGTH)
    truncated_title = entry.title.truncate(max_title_length)
    tweet.gsub!('TITLE_PLACEHOLDER', truncated_title)

    Twitter.update(tweet)
  end
end
