require 'spec_helper'

feature 'admin creates a new event' do
  before(:each) do
    sign_in_as_organizer
  end

  scenario 'with valid information' do
    location = Location.create!(street: "33 harrison ave",
                     city: 'Boston',
                     state: 'MA',
                     zipcode: '02135',
                     name: 'Launch Academy')
    event = EventType.create!(name: "Meeting")
    visit new_admin_event_path

    select 'Launch Academy', from: 'Location'
    select 'Meeting', from: 'Event type'
    fill_in 'Date', with: 'February 11, 2014'
    fill_in 'Start at', with: '6:45PM'
    fill_in 'End at', with: '6:45PM'
    fill_in 'Rsvp url', with: 'www.eventbrite.com'
    click_on 'Create Event'

    expect(page).to have_content('Event successfully created')
  end

  scenario 'with invalid information' do
    visit new_admin_event_path
    click_on 'Create Event'

    expect(page).to have_content('Invalid information. Please try again')
  end
end
