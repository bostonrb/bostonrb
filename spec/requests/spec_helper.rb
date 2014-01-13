RSpec.configure do |config|
  # ...
  # include our macro
  config.include(OmniauthMacros)
end

OmniAuth.config.test_mode = true
