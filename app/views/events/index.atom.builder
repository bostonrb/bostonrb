atom_feed :schema_date => 2009 do |feed|
  feed.title("Boston.rb upcoming Events")
  feed.subtitle("Events coming up for Boston Rubyists")
  feed.updated(@events.first.updated_at)

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title(event.title)
      entry.content(event.description_html, :type => 'html')
      entry.author do |author|
        author.name("Boston Ruby Group")
      end
    end
  end
end
