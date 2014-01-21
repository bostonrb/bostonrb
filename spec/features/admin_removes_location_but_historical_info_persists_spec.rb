require 'spec_helper'

feature 'admin removes location' do
  scenario 'with valid information' do
    event_location = Location.create!(:street => "33 harrison ave",
                     city: 'Boston',
                     state: 'MA',
                     zipcode: '02135',
                     name: 'Launch Academy')
    event_type = EventType.create!(name: "Meeting")
    event = Event.create(:location => event_location, :event_type => event_type, :date => '123', :start_at => '7', :end_at => '8', :rsvp_url => 'yahoo.com')
    visit edit_location_path(event_location)
    click_link 'Remove location'
    expect(page).to have_content('Successful deletion')
    
  end
  
  scenario 'location info persists in historical record' do
    event_location = Location.create!(:street => "33 harrison ave",
                     :city => 'Boston',
                     :state => 'MA',
                     :zipcode => '02135',
                     :name => 'Launch Academy')
    event_type = EventType.create!(name: "Meeting")
    event = Event.create(:location => event_location, :event_type => event_type, :date => '123', :start_at => '7', :end_at => '8', :rsvp_url => 'yahoo.com')
    
    visit edit_location_path(event_location)
    click_link 'Remove location'
    visit event_path(event)
    expect(page).to have_content(event_location.street)
  end
end
