require 'spec_helper'

feature 'Boston RB Project', %{
  As a BostonRB member
  I want to see information about project night
} do

  background do
    visit root_path
    click_link 'Project Night'
  end

  scenario 'Has link to setup instructions' do
    page.should have_link('Setup Instructions')
  end

  scenario 'Has link to RSVP' do
    page.should have_link('Sign up required')
  end
end
