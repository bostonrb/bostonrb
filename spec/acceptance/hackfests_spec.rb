require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'Hackfests', %{
  As a BostonRB member
  I want to learn more about Hackfests'
} do

  scenario 'Viewing the hackfesets page' do
    visit root_path
    click_link 'Hackfests'
    page.should have_content 'What is a Hackfest?'
  end
end
