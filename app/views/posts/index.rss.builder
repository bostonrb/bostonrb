xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "BostonRB Bloggers RSS Feed"
    xml.description "Posts written by members of the BostonRB community"
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        xml.title "#{post.blogger.name} - #{post.title}"
        xml.description post.summary
        xml.pubDate post.published_at.to_time.to_s(:rfc822)
        xml.link post.url
        xml.guid post.guid
      end
    end
  end
end

