Given /^a test presentation is present$/ do
  @user ||= Factory(:user, :twitter => "test_speaker")
  @presentation = Factory(:presentation, :title => "Test Presentation",
      :user => @user, :location => "Cambridge, MA",
      :date_of => DateTime.parse("July 14, 2009"), :description => "Test Description")
end

Given /^a presentation without a date_of is present$/ do
  @presentation = Factory(:presentation, :title => "Test Presentation",
      :user => @user, :location => "Cambridge, MA", :description => "Test Description")
end