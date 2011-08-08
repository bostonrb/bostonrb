require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'capybara/rspec'

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

VCR.config do |c|
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include Rails.application.routes.url_helpers, :type => :request
  
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end
