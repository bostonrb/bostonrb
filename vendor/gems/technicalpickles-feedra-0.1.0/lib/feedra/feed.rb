require 'feedzirra'

module Feedra
  module Feed

    def self.included(other)
      other.class_eval do
        extend ClassMethods

        validates_presence_of :feed_url
        has_many :entries, :dependent => :destroy, :order => "published_at DESC, created_at DESC"
        has_many :feed_errors
        named_scope :stale, lambda {{ :conditions => ['stale_at < ? OR stale_at IS NULL', Time.now] }}
        
        #before_create :populate_metadata_from_feed
        before_validation :normalize_feed_url 
      end
    end

    def create_feed_error_from_exception(ex)
      self.feed_errors.create_from_feedzirra_error(ex)
    end

    def create_entries_from_feedzirra_entries(feedzirra_entries)
      feedzirra_entries.each do |entry|
        entry_attributes = build_entry_attributes(entry.attributes)
        entries.create!(entry_attributes) unless entries.find_by_feedzirra_entry(entry)
      end
    end

    def populate_metadata_from_feed
      feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
      case feedzirra_feed
      when Fixnum, nil
        # err, what should I do?
      else
        self.title = feedzirra_feed.title
      end
    end

    def normalize_feed_url
      unless feed_url.blank? || feed_url =~ /^https?:\/\//i
        self.feed_url = "http://#{feed_url}"
      end
    end

    def normalized_url
      return url unless url.blank?
      return feed_url unless feed_url.blank?
    end

    def fetch!
      begin
        feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)

        case feedzirra_feed
        when Fixnum, nil
          create_feed_error_from_exception(feedzirra_feed)
        else
          feedzirra_feed.sanitize_entries!

          create_entries_from_feedzirra_entries(feedzirra_feed.entries)
        end
      rescue NoMethodError
        raise
      rescue Exception => ex
        create_feed_error_from_exception(ex)
      end
    end

    # hook, in case you need to add anything extra
    def build_entry_attributes(attributes)
      attributes
    end

    module ClassMethods
      def fetch_stale!
        stale.each do |feed|
          feed.fetch!
        end
      end
    end

  end

end
