require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'capybara/rspec'

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include Rails.application.routes.url_helpers, :type => :request
  
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end
