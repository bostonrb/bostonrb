# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell ActionMailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

config.gem 'jferris-mocha', 
           :version => '0.9.5.0.1241126838',
           :source  => 'http://gems.github.com', 
           :lib     => 'mocha'
config.gem 'factory_girl', 
           :version => '>= 1.2.2'
config.gem 'shoulda', 
           :version => '>= 2.10.2'
config.gem 'webrat',
           :version => '= 0.4.4'
config.gem 'cucumber',
           :version => '= 0.3.11'
config.gem 'fakeweb',
           :version => '= 1.2.0'

HOST = 'localhost'

require 'factory_girl'
begin require 'redgreen'; rescue LoadError; end

require 'fakeweb'
FakeWeb.allow_net_connect = false

GOOGLE_MAP_API_KEY = 'ABQIAAAAzMUFFnT9uH0xq39J0Y4kbhTJQa0g3IQ9GZqIMmInSLzwtGDKaBR6j135zrztfTGVOm2QlWnkaidDIQ'

