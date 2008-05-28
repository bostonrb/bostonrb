require 'simple-rss'

module FeedNormalizer

  # The SimpleRSS parser can handle both RSS and Atom feeds.
  class SimpleRssParser < Parser

    def self.parser
      SimpleRSS
    end

    def self.parse(xml, loose)
      begin
        atomrss = parser.parse(xml)
      rescue Exception => e
        #puts "Parser #{parser} failed because #{e.message.gsub("\n",', ')}"
        return nil
      end

      package(atomrss)
    end

    # Fairly low priority; a slower, liberal parser.
    def self.priority
      900
    end

    protected

    def self.package(atomrss)
      feed = Feed.new(self)

      # root elements
      feed_mapping = {
        :generator => :generator,
        :title => :title,
        :last_updated => [:updated, :lastBuildDate, :pubDate, :dc_date],
        :copyright => [:copyright, :rights],
        :authors => [:author, :webMaster, :managingEditor, :contributor],
        :urls => :link,
        :description => [:description, :subtitle]
      }

      map_functions!(feed_mapping, atomrss, feed)

      # custom channel elements
      feed.id = feed_id(atomrss)
      feed.image = image(atomrss)


      # entry elements
      entry_mapping = {
        :date_published => [:pubDate, :published, :dc_date],
        :urls => :link,
        :description => [:description, :summary],
        :content => [:content, :content_encoded, :description],
        :title => :title,
        :authors => [:author, :contributor, :dc_creator],
        :categories => :category
      }

      atomrss.entries.each do |atomrss_entry|
        feed_entry = Entry.new
        map_functions!(entry_mapping, atomrss_entry, feed_entry)

        # custom entry elements
        feed_entry.id = atomrss_entry.guid || atomrss_entry[:id] # entries are a Hash..
        feed_entry.copyright = atomrss_entry.copyright || (atomrss.respond_to?(:copyright) ? atomrss.copyright : nil)

        feed.entries << feed_entry
      end

      feed
    end

    def self.image(parser)
      if parser.respond_to?(:image) && parser.image
        if parser.image =~ /<url>/ # RSS image contains an <url> spec
          parser.image.scan(/<url>(.*)<\/url>/).to_s
        else
          parser.image # Atom contains just the url
        end
      elsif parser.respond_to?(:logo) && parser.logo
        parser.logo
      end
    end

    def self.feed_id(parser)
      overridden_value(parser, :id) || ("#{parser.link}" if parser.respond_to?(:link))
    end

    # gets the value returned from the method if it overriden, otherwise nil.
    def self.overridden_value(object, method)
      object.class.public_instance_methods(false).include? method
    end

  end
end
