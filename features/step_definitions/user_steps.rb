Then /^I should see an avatar for "([^\"]*)"$/ do |email|
  user = User.find_by_email(email)
  assert_select "img[src=?]", user.gravatar_url
end

