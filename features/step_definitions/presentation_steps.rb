Given /^an upcoming presentation$/ do
  pre = Factory(:presentation, :title => 'Upcoming Presentation', :presented_at => 1.day.from_now)
end

Then /^I should not see the upcoming presentation$/ do
  page.should_not have_content('Upcoming Presentation')
end

Then /^I should see presentation (\d+) for (.+)$/ do |id, date|
  presentation_content(id, date, :should)
end

Then /^I should not see presentation (\d+) for (.+)$/ do |id, date|
  presentation_content(id, date, :should_not)
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

def presentation_content(id, date, should_type)
  page.send(should_type, have_content("Test Presentation #{id}"))
  page.send(should_type, have_content("Test Description #{id}"))
  page.send(should_type, have_content("Person #{id}"))
  page.send(should_type, have_css("a[href='http://slides.com/#{id}']", :text => "Slides"))
end
