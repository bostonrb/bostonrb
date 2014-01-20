require 'spec_helper'

feature 'authenticate with github', %q{
  As an user,
  I want to log in using my Github Account
  So that I can have access to admin functionality
} do

  before(:each) do
    OmniAuth.config.test_mode = true

    # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
    OmniAuth.config.mock_auth[:github] = {
     :provider => 'github',
     :uid => '1234567',
     :credentials => {
        'token'=>'421ea6f9632b699d617561ae3a86f5bdd6c992f3'
      },
     :info => {
       :nickname => 'test',
       :email => 'info@gmail.com',
       :name => 'Test User',
       :first_name => 'Test',
       :last_name => 'User',
       :location => 'California',
       :verified => true
      }.stringify_keys!
    }.stringify_keys!

    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
  end

  # Acceptance Criteria
  # * Admins are authenticated via Github API
  # * If authentication fails, returns to the root path and flashes an error message

  scenario "Login button should log in" do
    VCR.use_cassette "octokit-look-up" do
      visit root_path
      click_on 'Sign In!'

      expect(page).to have_content('Sign Out')
    end
  end

  scenario 'user does not sign in when auth fails' do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path
    click_on 'Sign In!'
    expect(page).to have_content "Authentication Failed"
  end
end
