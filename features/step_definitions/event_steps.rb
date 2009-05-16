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

