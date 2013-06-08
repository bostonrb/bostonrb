require 'spec_helper'

feature 'Admin updates RSVP link', %{
  As a BostonRB admin
  I want to update the RSVP links
  so that users can RSVP for meetings
} do

  background do
    visit root_path
    login
    @meetup = create(:meetup)
  end

  scenario 'Logging in' do
    page.driver.response.status.should == 200
  end

  scenario 'View existing urls' do
    visit admin_meetups_path
    find_field('meetup[meeting_url]').value.should eq @meetup.meeting_url
    find_field('meetup[project_night_url]').value.should eq @meetup.project_night_url
  end

  scenario 'Edit the existing meeting url' do
    Meetup.delete_all
    meetup = create(:meetup)
    expected_url = "http://www.expected.com"
    visit admin_meetups_path
    fill_in 'meetup[meeting_url]', :with => expected_url
    click_button "Save"
    find_field('meetup[meeting_url]').value.should eq expected_url
    expect(meetup.reload.meeting_url).to eql(expected_url)
    visit root_path
    expect(page).to have_link('Sign up required', href: 'http://www.expected.com')
  end

  scenario 'Invalid edit to the existing meeting url' do
    expected_url = Meetup.first.meeting_url
    visit admin_meetups_path
    fill_in 'meetup[meeting_url]', :with => "A Website"
    click_button("Save")
    expect(Meetup.first.meeting_url).to eql(expected_url)
    expect(page).to have_css('.form-errors', :text => 'invalid URL')
  end

  scenario 'Visiting edit page without an existing meetup' do
    Meetup.delete_all
    visit admin_meetups_path
    find_field('meetup[meeting_url]').value.should eql nil
    find_field('meetup[project_night_url]').value.should eql nil
  end

  scenario 'Creating a meetup' do
    Meetup.delete_all
    visit admin_meetups_path
    fill_in 'meetup[meeting_url]', with: 'http://www.internet.com'
    fill_in 'meetup[project_night_url]', with: 'http://www.website.com'
    click_button 'Save'
    expect(Meetup.count).to eql(1)
  end

end
