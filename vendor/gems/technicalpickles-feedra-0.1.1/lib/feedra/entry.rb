module Feedra
  module Entry
    
    def self.included(other)
      other.class_eval do
        extend ClassMethods
        validates_presence_of :checksum
        belongs_to :feed
      end
      
    end

    def normalized_url
      return url unless url.blank?
      return feed.normalized_url unless feed.normalized_url.blank?
    end

    def summarized(options = {})
      Summifire.new(self.summary, self.content).to_s(options)
    end

    module ClassMethods
      def find_by_feedzirra_entry(feedzirra_entry)
        find_by_title_and_url(feedzirra_entry.title, feedzirra_entry.url)
      end

    end

  end
end
