Then /^I should see presentation (\d+) for (.+)$/ do |id, date|
  within("##{Date.parse(date).to_s}") do
    page.should have_content("Test Presentation #{id}")
    page.should have_content("Test Description #{id}")
    page.should have_content("Person #{id}")
    page.should have_css("a[href='http://slides.com/#{id}']", :text => "Slides")
  end
end

When /^I parse the feed$/ do
  @feed = SimpleRSS.parse(page.body)
end

Then /^I should get a rss item of presentation (\d+)$/ do |id|
  rss_presentation = @feed.items[id.to_i - 1]
  actual_presentation = Presentation.find_by_title("Test Presentation #{id}")
  rss_presentation.title.should == actual_presentation.title
  rss_presentation.description.should == actual_presentation.description
  rss_presentation.pubDate.to_date.should == actual_presentation.presented_at
  rss_presentation.link.should == presentation_url(actual_presentation)
  rss_presentation.guid.should == presentation_url(actual_presentation)
end
