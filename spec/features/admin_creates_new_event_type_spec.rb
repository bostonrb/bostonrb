require 'spec_helper'

feature 'Admin creates new event type' do

  before(:each) do
    sign_in_as_organizer
  end

  scenario 'valid input' do
    visit new_admin_event_type_path
    fill_in 'Name', with: 'Project Night'
    click_on 'Create Event type'

    expect(page).to have_content('Created successfully')
  end

  scenario 'invalid input' do
    visit new_admin_event_type_path
    click_on 'Create Event type'

    expect(page).to have_content('Invalid information. Please try again')
  end
end
