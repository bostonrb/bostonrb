xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Boston.rb upcoming Events"
    xml.description "Events coming up for Boston Rubyists"
    xml.link events_url, :rel => 'alternate', :format => 'text/html'
    xml.link events_url(:format => :rss), :rel => 'self'

    @events.each do |event|
      xml.item do
        xml.title event.title
        xml.description event.description
        xml.pubDate event.updated_at.xmlschema
        xml.link event_url(event), :rel => 'alternate', :format => 'text/html'
        xml.guid event_url(event)
      end
    end
  end
end
