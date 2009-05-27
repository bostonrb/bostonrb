xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Boston.rb upcoming Events"
    xml.description "Events coming up for Boston Rubyists"
    xml.link events_url, :rel => 'alternate', :format => 'text/html'
    xml.link events_url(:format => :rss), :rel => 'self'

    xml.item do
      xml.title "This RSS feed is gone"
      xml.description @message
      xml.link @new_feed_url
      xml.pubDate "Thu, 26 May 2009 21:00:00 EST"
    end
    
  end
end
