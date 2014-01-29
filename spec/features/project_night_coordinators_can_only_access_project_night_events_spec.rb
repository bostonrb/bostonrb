require 'spec_helper'

feature "project night coordinators can only edit/create project night events" do
  scenario 'pnc cannot edit meeting events' do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type)
    event = FactoryGirl.create(:event,:location_id => location.id,
                          :event_type_id => event_type.id)
    sign_in_as_project_manager
    visit edit_admin_event_path(event)

    expect(page).to have_content("Access Denied")
  end
  scenario "pnc creates new project night event" do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type, :name => "Project Night")
    sign_in_as_project_manager
    visit new_admin_event_path
    select location.name, from: 'Location'
    select event_type.name, from: 'Event type'
    fill_in 'Date', with: 'February 03, 2015'
    fill_in 'Start at', with: '6:45PM'
    fill_in 'End at', with: '6:45PM'
    fill_in 'Rsvp url', with: 'www.eventbrite.com'
    click_on 'Create Event'
    expect(page).to have_content('Event successfully created')
  end
  scenario "project night coordinators can edit project night events" do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type, :name => "Project Night")
    event = FactoryGirl.create(:event,:location_id => location.id,
                          :event_type_id => event_type.id)
    sign_in_as_project_manager
    visit edit_admin_event_path(event)
    fill_in 'Date',with: 'November 29, 2015'
    click_on 'Update Event'
    expect(page).to have_content("Event was successfully edited")
  end
  scenario 'proeject night coordinators cannot create meeting events' do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type)
    sign_in_as_project_manager
    visit new_admin_event_path
    select  location.name, from: 'Location'
    select event_type.name, from: 'Event type'
    fill_in 'Date', with: 'February 11, 2014'
    fill_in 'Start at', with: '6:45PM'
    fill_in 'End at', with: '6:45PM'
    fill_in 'Rsvp url', with: 'www.eventbrite.com'
    click_on 'Create Event'
    

    expect(page).to have_content('Project Night coordinators cannot make meeting events.')
  end
end