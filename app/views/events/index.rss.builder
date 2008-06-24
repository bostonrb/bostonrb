xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title "Boston.rb Events"
    xml.link "http://bostonrb.org"
    xml.description "Where Boston Rubyists hack around."
    xml.language('en-us')

    @events.each do |event|
      xml.item do
        xml.title event.title
        # FIXME really shouldn't have to say .html.haml
        xml.description render(:partial => 'show.html.haml', :locals => {:event => event})
        xml.pubDate event.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link event_url(event)
      end
    end
  end
end
