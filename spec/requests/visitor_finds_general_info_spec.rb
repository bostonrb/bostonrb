require 'spec_helper'

feature 'Visitor finds general info', %{
  As a visitor
  I want to find general info about Boston.rb
  In order to decide whether to join the group
} do

  before(:all) do
    VCR.insert_cassette('boston_rb_calendar')
    BostonRbCalendar.cache_next_event
  end

  scenario 'Visitor finds general info with no upcoming presentations' do
    visit root_path
    page.should have_content 'new Rubyists are always welcome'
    page.should_not have_content 'Upcoming Presentations'
  end

  scenario 'Visitor find general info with upcoming presentations' do
    create(:upcoming_presentation)
    visit root_path
    page.should have_content 'new Rubyists are always welcome'
    page.should have_content 'Upcoming Presentations'
    page.should have_content 'New Upcoming Presentation'
    page.should have_content 'New Upcoming Person'
    page.should have_content 'New Upcoming Description'
  end

  scenario "Visitor finds general info with next event" do
    visit root_path
    page.should have_content "Next Event"
    page.should have_link "next-event"
  end

  scenario "Visitor sees RSVP link to the monthly meeting" do
    meetup = create(:monthly_meeting)
    visit root_path
    page.should have_link('Sign up required', href: meetup.url)
  end

  scenario "Visitor sees RSVP link to project night" do
    meetup = create(:project_night)
    visit project_night_path
    page.should have_link('Sign up required', href: meetup.url)
  end

  after(:all) do
    VCR.eject_cassette
  end
end
