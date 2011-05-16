xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "BostonRB Presenstations RSS Feed"
    xml.description "Presentations given at BostonRB"
    xml.link presentations_url

    @presentations.each do |presentation|
      xml.item do
        xml.title presentation.title
        xml.description presentation.description
        xml.pubDate presentation.presented_at.to_time.to_s(:rfc822)
        xml.link presentation_url(presentation)
        xml.guid presentation_url(presentation)
      end
    end
  end
end

