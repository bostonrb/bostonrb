require 'spec_helper'

feature 'BostonRB Admin Interface', %{
  As the BostonRB admin
  I want to manage presentations
} do

  background do
    @presentation_1 = create(:presentation, :presented_at => 'May 10, 2011')
    @presentation_2 = build(:presentation, :presented_at => 'April 12, 2011', :presenter_names => 'Test Presenter')
    visit root_path
  end

  scenario 'Logging in' do
    sign_in_as_org
    visit admin_presentations_path
    page.driver.response.status.should == 200
  end

  scenario 'View existing presentations' do
    sign_in_as_org
    visit admin_presentations_path
    have_basic_presentation_content(@presentation_1, :should)
  end

  scenario 'Delete an existing presentations' do
    sign_in_as_org
    visit admin_presentations_path
    click_link 'Delete'
    have_basic_presentation_content(@presentation_1, :should_not)
  end

  scenario 'Edit an existing presentations' do
    sign_in_as_org
    visit admin_presentations_path
    click_link 'Edit'
    @presentation_1.title = 'New Title after edit'
    fill_in 'Title', :with => @presentation_1.title

    click_button 'Save Presentation'

    have_basic_presentation_content(@presentation_1, :should)
  end

  scenario 'Add new presentation' do
    sign_in_as_org
    visit admin_presentations_path
    click_link 'Add a presentation'
    fill_in 'Title',        :with => @presentation_2.title
    fill_in 'Presenters',   :with => @presentation_2.presenter_names
    fill_in 'Description',  :with => @presentation_2.description
    fill_in 'Video URL',    :with => @presentation_2.video_url
    fill_in 'Slides URL',   :with => @presentation_2.slides_url
    fill_in 'Presented At', :with => @presentation_2.presented_at

    click_button 'Save Presentation'

    current_path.should eq(admin_presentations_path)
    have_basic_presentation_content(@presentation_1, :should)
    have_basic_presentation_content(@presentation_2, :should)
  end

end
