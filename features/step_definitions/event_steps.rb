Given /^a future special event exists with a title of "([^\"]*)"$/ do |title|
  Factory(:special_event, :date => 2.days.from_now, :title => title)
end

Given /^a future recurring event exists with a title of "([^\"]*)"$/ do |title|
  Factory(:recurring_event, :date => 2.days.from_now, :title => title)
end

Given /^the "([^\"]*)" event's location is "([^\"]*)"$/ do |title, location|
  event = Event.find_by_title(title)
  event.update_attribute(:location, location)
end

Then /^I should see a map$/ do
  assert_select "#map"
end

When /^I should see "([^\"]*)" under (.*)$/ do |text, id|
  id = id.gsub(' ', '_')
  within "##{id}" do |scope|
    assert_contain text, scope
  end
end

Then /^I should not see "([^\"]*)" under (.*)$/ do |text, id|
  id = id.gsub(' ', '_')
  within "##{id}" do |scope|
    assert_not_contain text, scope
  end
end

Then /^I should see that there are (\d+) future events$/ do |count|
  within "#boston_rb a[href='/#events']" do |scope|
    assert_contain "#{count}", scope
  end
end

Then /^I should see an entry for "([^\"]*)"$/ do |title|
  assert_select 'feed > entry' do
    assert_select 'title', title
  end
end

Then /^I should not see an entry for "([^\"]*)"$/ do |title|
  assert_select 'feed > entry' do
    assert_select 'title', :text => title, :count => 0
  end
end

Then /^I should be redirected to "([^\"]*)"$/ do |page_name|
  #puts request.headers.inspect
  request.headers['HTTP_REFERER'].should_not be_nil
  request.headers['HTTP_REFERER'].should_not == request.request_uri
  Then "I should be on the #{page_name} page"
end
