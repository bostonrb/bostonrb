require "spec_helper"

feature 'view individual events for greater detail' do

  before(:each) do
    sign_in_as_organizer
  end

  scenario '' do
    location = Location.create!(:street => '33 harrison ave',
                                :city => 'Boston',
                                :state => 'MA',
                                :zipcode => '02135',
                                :name => 'Launch Academy')
    event_type = EventType.create!(:name => "Meeting")
    event = Event.create!(:location_id => location.id,
                          :event_type_id => event_type.id,
                          :date => '11/29/2014',
                          :start_at => '4:06am',
                          :end_at => 'midnight',
                          :rsvp_url => 'http://justusunlimited.com')
    visit admin_event_path(event)
    expect(page).to have_content(event.location.name)
    expect(page).to have_content(event.location.street)
    expect(page).to have_content(event.event_type.name)
    expect(page).to have_content(event.date)
    expect(page).to have_content(event.start_at)
  end
end
