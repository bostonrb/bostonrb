if defined? Rails.configuration
  config = Rails.configuration

  config.gem 'taf2-curb', :lib => 'curb', :version => '0.2.8.0' # feezirra would normally depend on this, but doesn't depend a working it works with
  config.gem 'pauldix-feedzirra', :lib => 'feedzirra', :source => 'http://gems.github.com'
else
  gem 'taf2-curb', '= 0.2.8.0'
  gem 'pauldix-feedzirra'

  require 'curb'
  require 'feedzirra'
end


require 'summifire'
require 'feedra/entry'
require 'feedra/feed'
require 'feedra/feed_error'
require 'feedra/extensions/feedzirra'
