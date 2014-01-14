require 'spec_helper'

feature 'Admin creates new location' do
  scenario 'input valid information' do
    visit new_location_path
    fill_in 'Name', with: 'Brightcove Offices'
    fill_in 'Street', with: '290 Congress St'
    fill_in 'Suite address', with: '3rd floor'
    fill_in 'City', with: 'Boston'
    fill_in 'State', with: 'MA'
    fill_in 'Zipcode', with: '02125'
    click_on 'Create Location'

    expect(page).to have_content("Created location successfully")
  end

  scenario 'input invalid information' do
    visit new_location_path
    click_on 'Create Location'

    expect(page).to have_content("Invalid information. Please try again")
  end
end
