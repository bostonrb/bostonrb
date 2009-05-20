# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

config.action_mailer.delivery_method = :sendmail

GOOGLE_MAP_API_KEY = 'ABQIAAAA5DmfAcONGodqQq2WJjcL2xRVmJNk76XDhrH9yChLo28oBQNqVhTI1FI8bDPEtkxfWbI5NT2tPk5DqA'

HOST = "bostonrb.org"

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :domain => "bostonrb.org",
  :perform_deliveries => true,
  :address => 'smtp.ey01.engineyard.com',
  :port => 25
}

