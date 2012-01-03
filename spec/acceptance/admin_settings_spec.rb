require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'BostonRB Settings Admin Interface', %{
  As the BostonRB admin
  I want to manage settings
} do

  background do
    @setting_1 = Factory(:setting)
    @setting_2 = Factory.build(:setting, :value => 'another value')
    visit root_path
  end

  scenario 'Logging in' do
    login
    visit admin_settings_path
    page.driver.response.status.should == 200
  end

  scenario 'View existing settings' do
    login
    visit admin_settings_path
    have_setting_content(@setting_1, :should)
  end

  scenario 'Delete an existing settings' do
    login
    visit admin_settings_path
    click_link 'Delete'
    have_setting_content(@setting_1, :should_not)
  end

  scenario 'Edit an existing setting' do
    login
    visit admin_settings_path
    click_link 'Edit'
    @setting_1.value = 'New Setting Value'
    fill_in 'Value', :with => @setting_1.value

    click_button 'Save Setting'

    have_setting_content(@setting_1, :should)
  end

  scenario 'Add new setting' do
    login
    visit admin_settings_path
    click_link 'Add a Setting'
    fill_in 'Key',     :with => @setting_2.key
    fill_in 'Value',   :with => @setting_2.value

    click_button 'Save Setting'

    current_path.should eq(admin_settings_path)
    have_setting_content(@setting_1, :should)
    have_setting_content(@setting_2, :should)
  end
end
