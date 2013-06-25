require 'spec_helper'

feature 'Admin updates RSVP link', %{
  As a BostonRB admin
  I want to update the RSVP links
  so that users can RSVP for meetings
} do

  background do
    visit root_path
    login
    @project_night = create(:project_night)
  end

  scenario 'Logging in' do
    page.driver.response.status.should == 200
  end

  scenario 'View existing urls' do
    visit admin_project_nights_path
    find_field('project_night[url]').value.should eq @project_night.url
  end

  scenario 'Edit the existing meeting url' do
    ProjectNight.delete_all
    project_night = create(:project_night)
    expected_url = "http://www.expected.com"
    visit admin_project_nights_path
    fill_in 'project_night[url]', :with => expected_url
    click_button "Save"
    find_field('project_night[url]').value.should eq expected_url
    expect(project_night.reload.url).to eql(expected_url)
    visit project_night_path
    expect(page).to have_link('Sign up required', href: 'http://www.expected.com')
  end

  scenario 'Invalid edit to the existing meeting url' do

    expected_url = ProjectNight.first.url
    visit admin_project_nights_path
    fill_in 'project_night[url]', :with => "A Website"
    click_button("Save")
    expect(ProjectNight.first.url).to eql(expected_url)
    expect(page).to have_css('.form-errors', :text => 'invalid URL')
  end

  scenario 'Visiting edit page without an existing project_night' do
    ProjectNight.delete_all
    visit admin_project_nights_path
    find_field('project_night[url]').value.should eql nil
  end

  scenario 'Creating a monthly meeting' do
    ProjectNight.delete_all
    visit admin_project_nights_path
    fill_in 'project_night[url]', with: 'http://www.internet.com'
    click_button 'Save'
    expect(ProjectNight.count).to eql(1)
  end

end
