require 'spec_helper'

feature 'Visitor finds general info', %{
  As a visitor
  I want to find general info about Boston.rb
  In order to decide whether to join the group
} do

  scenario 'Visitor finds general info with no upcoming presentations' do
    visit root_path
    page.should have_content 'new Rubyists are always welcome'
    page.should_not have_content 'Upcoming Presentations'
  end

  scenario 'Visitor find general info with upcoming presentations' do
    create(:upcoming_presentation)
    visit root_path
    page.should have_content 'new Rubyists are always welcome'
    page.should have_content 'Upcoming Presentations'
    page.should have_content 'New Upcoming Presentation'
    page.should have_content 'New Upcoming Person'
    page.should have_content 'New Upcoming Description'
  end
end
