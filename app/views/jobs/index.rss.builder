xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title "Boston.rb Jobs"
    xml.link "http://bostonrb.org"
    xml.description "Where Boston Rubyists hack around."
    xml.language('en-us')

    (@jobs + @gigs).each do |job|
      xml.item do
        xml.title "#{job.location}: #{job.title} at #{job.organization}" 
        xml.description markdown(job.description)
        xml.pubDate job.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link job_path(job)
      end
    end
  end
end