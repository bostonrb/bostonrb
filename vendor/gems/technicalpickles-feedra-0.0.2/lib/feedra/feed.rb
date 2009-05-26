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
        
        before_create :populate_metadata_from_feed
        before_validation :normalize_feed_url 
      end
    end

    def create_feed_error_from_exception(ex)
      case ex
      when Fixnum, nil
        self.feed_errors.create :error_type => ex.class.to_s, :message => ex.to_s
      else
        self.feed_errors.create :error_type => ex.class.to_s, :message => ex.message, :trace => ex.backtrace
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

          feedzirra_feed.entries.each do |entry|
            entry_attributes = build_entry_attributes(entry.attributes)
            entries.create!(entry_attributes) unless entries.find_by_checksum(entry.checksum)
          end
        end
      rescue Exception => ex
        create_feed_error_from_exception(ex)
      end
    end

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
