require 'spec_helper'

feature 'Admin updates RSVP link', %{
  As a BostonRB admin
  I want to update the RSVP links
  so that users can RSVP for meetings
} do

  background do
    visit root_path
    login
    @monthly_meeting = create(:monthly_meeting)
  end

  scenario 'Logging in' do
    page.driver.response.status.should == 200
  end

  scenario 'View existing urls' do
    visit admin_monthly_meetings_path
    find_field('monthly_meeting[url]').value.should eq @monthly_meeting.url
  end

  scenario 'Edit the existing meeting url' do
    MonthlyMeeting.delete_all
    monthly_meeting = create(:monthly_meeting)
    expected_url = "http://www.expected.com"
    visit admin_monthly_meetings_path
    fill_in 'monthly_meeting[url]', :with => expected_url
    click_button "Save"
    find_field('monthly_meeting[url]').value.should eq expected_url
    expect(monthly_meeting.reload.url).to eql(expected_url)
    visit root_path
    expect(page).to have_link('Sign up required', href: 'http://www.expected.com')
  end

  scenario 'Invalid edit to the existing meeting url' do

    expected_url = MonthlyMeeting.first.url
    visit admin_monthly_meetings_path
    fill_in 'monthly_meeting[url]', :with => "A Website"
    click_button("Save")
    expect(MonthlyMeeting.first.url).to eql(expected_url)
    expect(page).to have_css('.form-errors', :text => 'invalid URL')
  end

  scenario 'Visiting edit page without an existing monthly_meeting' do
    MonthlyMeeting.delete_all
    visit admin_monthly_meetings_path
    find_field('monthly_meeting[url]').value.should eql nil
  end

  scenario 'Creating a monthly meeting' do
    MonthlyMeeting.delete_all
    visit admin_monthly_meetings_path
    fill_in 'monthly_meeting[url]', with: 'http://www.internet.com'
    click_button 'Save'
    expect(MonthlyMeeting.count).to eql(1)
  end

end
