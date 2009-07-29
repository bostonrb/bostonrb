Then /^I should see an avatar for "john@doe.com"$/ do
  assert_select "img[src*=?]", "http://gravatar.com/avatar/"
end

Given /^the "([^\"]*)" user's name is "([^\"]*)"$/ do |email, name|
  user = User.find_by_email email
  user.update_attribute(:name, name)
end

