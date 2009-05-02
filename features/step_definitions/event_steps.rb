Given /^the "([^\"]*)" event is not a main event$/ do |title|
  event = Event.find_by_title(title)
  event.update_attribute(:main, false)
end

