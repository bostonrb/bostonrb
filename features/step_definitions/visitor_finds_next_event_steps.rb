##
# This step is probably way too brittle to keep for too long.
##

Then /^I should see event information$/ do
    #some event at someplace
    page.find("h3#next-event").text.match(/.*\sat\s.*/).should_not be_nil
    #Day of Week, Month day time to time
    page.find("h3#next-event").text.match(/.*,\s.*\dPM\sto\s\dPM/).should_not be_nil
    page.should have_css('h3#next-event a')
    #The link goes to a google maps page.
    find("h3#next-event a")[:href].match(/maps\.google\.com\/maps\?q=.*/).should_not be_nil
end