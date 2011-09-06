source :rubygems

gem 'rails',            '~> 3.1.0.rc5'
gem 'arel', '2.1.4'
gem 'jquery-rails'
gem 'uglifier'

gem 'rake',             '~> 0.8.7'
gem 'high_voltage',     '~> 0.9'
gem 'hoptoad_notifier', '~> 2.4.2'
gem 'jquery-rails'
gem 'kaminari',         '~> 0.12.4'
gem 'sass-rails',       :git => 'https://github.com/rails/sass-rails.git', :ref => 'eee12e2e0bbfca56d458c82df47213e130ef5830'
gem 'compass',          :git => 'https://github.com/chriseppstein/compass.git', :branch => 'rails31'
gem 'simple_form',      '~> 1.4.0'
gem 'friendly_id',      '~> 3.3.0.rc2'
gem 'stamp',            '~> 0.1' # Jeremy can be apprehended if he breaks semantic versioning rules.

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails',    '~> 2.6.0'
  gem 'ruby-debug19',   '~> 0.11.6', :require => 'ruby-debug'
  gem 'memcache-client'
end

group :production, :staging do
  gem 'pg', '~> 0.10'
  gem 'therubyracer'
  gem 'redis-store', :git => 'https://github.com/jodosha/redis-store.git', :ref => 'aca3fbf003a04fe8e9bd76441aa8a3e765cd0a7b'
end

group :test do
  gem 'vcr', "~> 1.10.3"
  gem 'webmock', "~> 1.6.4"
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'bourne',             '~> 1.0'
  gem 'capybara',           '~> 1.0.0'
  gem 'database_cleaner',   '~> 0.6.0'
  gem 'timecop',            '~> 0.3.5'
  gem 'email_spec',         '~> 1.1'
  gem 'valid_attribute'
  gem 'launchy'
  gem 'simple-rss',         '~> 1.2.3'
end
