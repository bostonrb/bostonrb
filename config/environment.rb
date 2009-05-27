RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

require 'extensions/array' # needs to load before initializers

Rails::VendorGemSourceIndex.silence_spec_warnings = true

Rails::Initializer.run do |config|
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir| 
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end

  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_boston_rb_session',
    :secret      => 'a406a09e903c61fa55fadce763e5df7cae1320592290a64e0665412cd9aff9b18116daeab3309fe69bfb3ffc6da224671f5ea5ab96ad7245b276a06a448f2c0a'
  }

  config.gem 'BlueCloth',
    :lib     => 'bluecloth'
  config.gem 'RedCloth',
    :lib     => 'redcloth',
    :version => '> 3.0.4'
  config.gem 'builder',
    :version => '2.1.2'
  config.gem 'dancroak-validates_email_format_of',
    :source  => 'http://gems.github.com',
    :lib     => 'validates_email_format_of'
  config.gem 'dancroak-twitter-search',
    :version => "0.5.5",
    :source  => 'http://gems.github.com',
    :lib     => 'twitter_search'
  config.gem 'feed-normalizer',
    :version => '1.4.0'
  config.gem 'gravtastic',
    :version => '>= 2.1.0'
  config.gem 'haml',
    :version => '2.1.0'
  config.gem "json",
    :version => '1.1.6'
  config.gem 'simple-rss',
    :version => '1.1'
  config.gem 'technicalpickles-has_markup',
    :lib     => 'has_markup',
    :source  => 'http://gems.github.com',
    :version => '0.1.4'
  config.gem "thoughtbot-clearance", 
    :lib     => 'clearance', 
    :source  => 'http://gems.github.com', 
    :version => '0.6.5'
  config.gem 'thoughtbot-pacecar',
    :lib     => "pacecar",
    :source  => 'http://gems.github.com', 
    :version => '1.1.5'
  config.gem "yfactorial-utility_scopes",
    :lib     => "utility_scopes",
    :source  => 'http://gems.github.com', 
    :version => '0.2.2'
  config.gem "giraffesoft-resource_controller",
    :lib     => "resource_controller",
    :version => "0.6.1"
  config.gem "feedra"
  config.gem "dancroak-le-git",
    :lib     => "le_git",
    :version => "0.0.5"
  config.gem "happymapper"
  config.gem "rest-client",
    :lib     => 'rest_client'
  config.gem "technicalpickles-feedra",
    :lib     => "feedra",
    :version => "0.0.2"
end

DO_NOT_REPLY = "dcroak+bostonrb@thoughtbot.com"
