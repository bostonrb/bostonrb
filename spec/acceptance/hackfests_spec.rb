require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'Hackfests', %{
  As a BostonRB member
  I want to learn more about Hackfests'
} do

  background do
    VCR.insert_cassette('boston_rb_calendar')
  end

  scenario 'Viewing the hackfesets page' do
    visit root_path
    click_link 'Hackfests'
    page.should have_content 'What is a Hackfest?'
  end

  after(:each) do
    VCR.eject_cassette
  end
end
