require 'spec_helper'

feature 'Admin creates new event' do

  before(:each) do
    sign_in_as_organizer
  end

  scenario 'deleted location does not exist' do
    location = FactoryGirl.create(:location, time_of_deletion: Time.now )
    visit new_admin_event_path
    find_field('Location').should_not have_content('Mission Control')
  end
end
