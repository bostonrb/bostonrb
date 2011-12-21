class Post < ActiveRecord::Base
  belongs_to :blogger
  has_and_belongs_to_many :categories

  delegate :twitter_username, :name, :url, :title, :to => :blogger, :prefix => true

  scope :by_freshness, order('published_at desc')
  scope :with_blogger,    includes(:blogger)

  def self.most_recent(params = {})
    by_freshness.with_blogger.page(params[:page]).per(params[:per])
  end

  def self.new_from_entries(blogger, entries)
    entries.map do |entry|
      new(blogger:      blogger,
          title:        entry.title,
          summary:      entry.summary || entry.content,
          url:          entry.url,
          published_at: entry.published,
          guid:         entry.id,
          categories:   Category.find_or_create_many_by_name(entry.categories))
    end
  end

  def category_names
    categories.map(&:name)
  end

  SHORT_URL_LENGTH = 20 # should query as this may change.  See https://dev.twitter.com/docs/tco-link-wrapper/faq#Will_t.co-wrapped_links_always_be_the_same_length
  def default_tweet_message
    tweet = "Boston Rubyist #{blogger_twitter_username} blogs about TITLE_PLACEHOLDER #{url}"
    max_title_length = 140 - (tweet.length - 'TITLE_PLACEHOLDER'.length - url.length + SHORT_URL_LENGTH)
    truncated_title = title.truncate(max_title_length)

    tweet.gsub('TITLE_PLACEHOLDER', truncated_title)
  end

  def tweet tweet_message=default_tweet_message
    Twitter.update(tweet_message)
  end

end
