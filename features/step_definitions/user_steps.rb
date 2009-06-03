Then /^I should see an avatar for "([^\"]*)"$/ do |email|
  user = User.find_by_email(email)
  assert_select "img[src=?]", user.gravatar_url
end

Given /^the "([^\"]*)" user's name is "([^\"]*)"$/ do |email, name|
  user = User.find_by_email email
  user.update_attribute(:name, name)
end

