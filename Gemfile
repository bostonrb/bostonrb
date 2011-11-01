source :rubygems

gem 'rails',                   '~> 3.1.1'
gem 'jquery-rails',            '~> 1.0.0'

gem 'high_voltage',            '~> 0.9'
gem 'kaminari',                '~> 0.12.4'
gem 'simple_form',             '~> 1.4.0'
gem 'friendly_id',             '~> 3.3.0.1'
gem 'stamp',                   '~> 0.1.0'

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails',    '~> 2.6.0'
  gem 'ruby-debug19',   '~> 0.11.6', :require => 'ruby-debug'
  gem 'memcache-client'
end

group :assets do
  gem 'sass-rails',   '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
  gem 'compass',      '~> 0.12.alpha'
end

group :production, :staging do
  gem 'pg',          '~> 0.10'
  gem 'redis-store', '~> 1.0.0.1'
end

group :test do
  gem 'vcr',                '~> 1.10.3'
  gem 'webmock',            '~> 1.6.4'
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'bourne',             '~> 1.0'
  gem 'capybara',           '~> 1.1.0'
  gem 'database_cleaner',   '~> 0.6.0'
  gem 'timecop',            '~> 0.3.5'
  gem 'email_spec',         '~> 1.1'
  gem 'valid_attribute',    '~> 1.2.0'
  gem 'launchy'
  gem 'simple-rss',         '~> 1.2.3'
end
