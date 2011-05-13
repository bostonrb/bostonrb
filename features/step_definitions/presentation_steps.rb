Then /^I should see presentation (\d+) for (.+)$/ do |id, date|
  within("##{Date.parse(date).to_s}") do
    page.should have_content("Test Presentation #{id}")
    page.should have_content("Test Description #{id}")
    page.should have_content("Person #{id}")
    page.should have_css("a[href='http://slides.com/#{id}']", :text => "Slides")
  end
end

