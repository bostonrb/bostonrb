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
  config.extend VCR::RSpec::Macros
  config.before(:suite) do
    VCR.insert_cassette('boston_rb_calendar')
    Rake.application.rake_require "../lib/tasks/cron"
    Rake::Task.define_task(:environment)    
    Rake::Task['cron'].invoke
    VCR.eject_cassette
  end
end
