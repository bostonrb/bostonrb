require 'spec_helper'

feature 'Admin creates a new event' do
  scenario 'with only project night level access' do
    pending 'level of admin not defined'
  end

  scenario 'with valid information' do
    Location.create!(street: "33 harrison ave",
                     city: 'Boston',
                     state: 'MA',
                     name: 'Launch Academy')
    EventType.create!(name: "Meeting")
    visit new_event_path

    #save_and_open_page
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
    visit new_event_path

    click_on 'Create Event'

    expect(page).to have_content('Invalid information. Please try again')
  end
end
