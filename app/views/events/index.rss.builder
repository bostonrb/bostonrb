xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Boston.rb upcoming Events"
    xml.description "Events coming up for Boston Rubyists"
    xml.link events_url(:rss), :format => 'rss'
    
    @events.each do |event|
      xml.item do
        xml.title event.title
        xml.description event.description
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_url(event)
        xml.guid event_url(event)
      end
    end
  end
end
