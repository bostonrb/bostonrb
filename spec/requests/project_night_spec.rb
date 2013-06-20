require 'spec_helper'

feature 'Boston RB Project', %{
  As a BostonRB member
  I want to see information about project night
} do

  before(:all) do
    VCR.insert_cassette('boston_rb_calendar')
  end

  background do
    Meetup.create(meeting_url: 'http://www.mike.com',
                  project_night_url: 'http://www.greg.com')
    visit root_path
    click_link 'Project Night'
  end

  scenario 'Has link to setup instructions' do
    page.should have_link('Setup Instructions')
  end

  scenario 'Has link to RSVP' do
    page.should have_link('Sign up required')
  end

  after(:each) do
    VCR.eject_cassette
  end
end
