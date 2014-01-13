module AuthenticationHelper
  def sign_in_with(provider, mock_options=nil)
    if mock_options == :invalid_credentials
      OmniAuth.config.mock_auth[provider] = :invalid_credentials
    elsif mock_options
      OmniAuth.config.add_mock provider, mock_options
    end

    visit "/auth/#{provider}"
  end
end
