require "spec_helper"

feature 'view individual events for greater detail' do

  before(:each) do
    sign_in_as_organizer
  end

  scenario 'admin views event' do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type, :name => "Meeting")
    event = FactoryGirl.create(:event, :location_id => location.id, :event_type_id => event_type.id)
    visit admin_event_path(event)
    expect(page).to have_content(event.location.name)
    expect(page).to have_content(event.location.street)
    expect(page).to have_content(event.event_type.name)
    expect(page).to have_content(event.date)
    expect(page).to have_content(event.start_at)
  end
end
