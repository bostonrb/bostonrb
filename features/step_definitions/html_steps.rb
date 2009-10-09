When /^I select a date (\d+) days? in the future for "(.*)"$/ do |days, field|
  date = days.to_i.days.from_now
  When %{I select "#{date}" as the "#{field}" date and time}
end

When /^I select a date (\d+) days? in the past for "(.*)"$/ do |days, field|
  date = days.to_i.days.ago
  When %{I select "#{date}" as the "#{field}" date and time}
end

Then /^I should see a text field containing "(.*)"$/ do |contents|
  assert_select "input[type=text][value=?]", contents
end

Then /^I should see a select containing "(.*)"$/ do |contents|
  assert_select "select option[selected=selected]", :text => contents
end

Then /^I should( not)? see an image named "(.*)"$/ do |invisible, image|
  assert_select "img[src*=?]", image, :count => (invisible.nil? ? 1 : 0)
end

When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link_text, selector|
  click_link_within(selector, link_text)
end

