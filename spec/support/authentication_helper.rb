module AuthenticationHelper

 def stub_auth_response
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

  def sign_in_as_organizer
    VCR.use_cassette "octokit-look-up-organizer" do
      stub_auth_response
      visit '/auth/github'
    end
  end

  def sign_in_as_project_manager
    VCR.use_cassette "octokit-look-up-project-manager" do
      stub_auth_response
      visit '/auth/github'
    end
  end

end
