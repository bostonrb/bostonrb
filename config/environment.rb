RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

require 'extensions/array' # needs to load before initializers

Rails::Initializer.run do |config|
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir| 
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end
  
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_boston_rb_session',
    :secret      => 'a406a09e903c61fa55fadce763e5df7cae1320592290a64e0665412cd9aff9b18116daeab3309fe69bfb3ffc6da224671f5ea5ab96ad7245b276a06a448f2c0a'
  }
  
  config.gem 'validates_email_format_of', :source => 'http://gems.github.com'
  config.gem 'BlueCloth', :lib => 'bluecloth'
  config.gem 'acts_as_paranoid', :version => '0.3.1'
  config.gem 'builder', :version => '2.1.2'
  config.gem 'feed-normalizer', :version => '1.4.0'
  config.gem 'haml', :version => '2.0.1'
  config.gem 'has_finder', :version => '0.1.5'
  config.gem 'hpricot', :version => '0.6'
  config.gem 'mocha', :version => '0.5.6'
  config.gem 'quietbacktrace'
  config.gem 'simple-rss', :version => '1.1'
  config.gem 'thoughtbot-factory_girl', :version => '1.1', :lib => 'factory_girl', :source => 'http://gems.github.com'
end
