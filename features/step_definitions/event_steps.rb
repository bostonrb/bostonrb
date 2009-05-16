Given /^the "([^\"]*)" event is not a main event$/ do |title|
  event = Event.find_by_title(title)
  event.update_attribute(:main, false)
end

Given /^a future recurring event exists with a title of "([^\"]*)"$/ do |title|
  Factory(:recurring_event, :date => 2.days.from_now, :title => title)
end

