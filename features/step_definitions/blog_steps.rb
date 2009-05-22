Given /^I have setup my blog as "([^\"]*)"$/ do |feed_url|
  User.last.update_attributes!(:feed_attributes => {:feed_url => feed_url})
end

Given /^my latest post is "([^\"]*)"$/ do |title|
  Factory(:entry, :feed => User.last.feed, :title => title)
end

