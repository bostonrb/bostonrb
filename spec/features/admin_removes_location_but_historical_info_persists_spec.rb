require 'spec_helper'

feature 'admin removes location' do

  before(:each) do
    sign_in_as_organizer
  end

  scenario 'with valid information' do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type, :name => "Meeting")
    event = FactoryGirl.create(:event, :location_id => location.id, :event_type_id => event_type.id)
    visit edit_admin_location_path(location)
    click_on 'Remove location'
    expect(page).to have_content('Successful deletion')
  end

  scenario 'location info persists in historical record' do
    location = FactoryGirl.create(:location)
    event_type = FactoryGirl.create(:event_type, :name => "Meeting")
    event = FactoryGirl.create(:event, :location_id => location.id, :event_type_id => event_type.id)

    visit edit_admin_location_path(location)
    click_on 'Remove location'
    visit admin_event_path(event)
    expect(page).to have_content(location.street)
  end
end
