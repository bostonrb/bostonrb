require 'spec_helper'

feature 'authenticate with github', %q{
  As an user,
  I want to log in using my Github Account
  So that I can have access to admin functionality
}, authentication: true,
vcr: {cassette_name: 'github/auth'} do

  # Acceptance Criteria
  # * Admins are authenticated via Github API
  # * If authentication fails, returns to the root path and flashes an error message

  describe 'successful authentication' do
    it "Login button should log in" do
      visit root_path
      expect(page).to have_content('Sign Out')
    end
  end

end
