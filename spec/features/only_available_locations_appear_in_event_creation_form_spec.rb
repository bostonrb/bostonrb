require 'spec_helper'

feature 'Admin creates new location' do
  location = Location.create(name: 'Mission Control', street: "33 Harrison", city: "Boston", state: "Massachusetts", zipcode: '02125', time_of_deletion: Time.now)
  visit new_event_path
  select :location  

  deleted_option = page.find(:css, '#event_location_id option:contains("Mission Control")')
  expect(deleted_option).to be_nil
end
