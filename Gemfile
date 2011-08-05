source :rubygems

gem 'rails',            '~> 3.1.0.rc5'
gem 'jquery-rails'
gem 'uglifier'

gem 'rake',             '~> 0.8.7'
gem 'high_voltage',     '~> 0.9'
gem 'hoptoad_notifier', '~> 2.4.2'
gem 'jquery-rails'
gem 'kaminari',         '~> 0.12.4'
gem 'sass-rails', :git => 'https://github.com/rails/sass-rails.git', :ref => 'eee12e2e0bbfca56d458c82df47213e130ef5830'
gem 'compass',    :git => 'https://github.com/chriseppstein/compass.git', :branch => 'rails31'
gem 'simple_form',      '~> 1.4.0'
gem 'friendly_id',      '~> 3.2.1'

# This fork of GCal4Ruby is the only one with 
# serious support for Recurring events.
gem "gcal4ruby", :git => "git://github.com/bruno/GCal4Ruby.git"

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails',  '~> 2.6.0'
  gem 'ruby-debug19', '~> 0.11.6', :require => 'ruby-debug'
end

group :production, :staging do
  gem 'pg', '~> 0.10'
  gem 'therubyracer'
end

group :test do
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
