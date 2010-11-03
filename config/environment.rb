RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

require 'extensions/array' # needs to load before initializers

Rails::VendorGemSourceIndex.silence_spec_warnings = true

Rails::Initializer.run do |config|
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir| 
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end

  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :key    => '_boston_rb_session',
    :secret => 'a406a09e903c61fa55fadce763e5df7cae1320592290a64e0665412cd9aff9b18116daeab3309fe69bfb3ffc6da224671f5ea5ab96ad7245b276a06a448f2c0a'
  }
  
  config.time_zone = 'Eastern Time (US & Canada)'

  config.gem 'mysql'
  config.gem 'BlueCloth',
    :lib     => 'bluecloth'
  config.gem 'RedCloth',
    :lib     => 'redcloth',
    :version => '= 4.2.2'
  config.gem 'builder',
    :version => '2.1.2'
  config.gem 'gravtastic',
    :version => '= 2.1.0'
  config.gem 'haml',
    :version => '2.2.20'
  config.gem "json",
    :version => '= 1.4.6'
  config.gem 'has_markup',
    :version => '0.1.5'
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
  config.gem "josevalim-inherited_resources",
    :lib     => "inherited_resources",
    :version => "0.8.5"
  config.gem 'dancroak-twitter-search',
    :version => "0.5.5",
    :source  => 'http://gems.github.com',
    :lib     => 'twitter_search'
  config.gem "dancroak-le-git",
    :lib     => "le_git",
    :version => "0.0.5"
  config.gem 'taf2-curb', :lib => 'curb', :version => '0.2.8.0' # feezirra would normally depend on this, but doesn't depend a working it works with
  config.gem "technicalpickles-feedra",
    :lib     => "feedra",
    :version => "0.1.1"
  config.gem "will_paginate",
    :version => "2.3.11"

  config.gem 'chronic', :version => '0.2.3'
  config.gem 'hoptoad_notifier', :version => '2.2.0'

  config.gem 'truncate_html', :version => '0.1.2'

  # FIXME explicit dependencies to make sure moonshine installs their native dependencies
  config.gem 'nokogiri'
  config.gem 'curb'

  config.gem 'ri_cal', :version => '~> 0.8.5'
end

DO_NOT_REPLY = "dcroak+bostonrb@thoughtbot.com"
