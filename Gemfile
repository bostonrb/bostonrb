source :rubygems

gem 'rails',            '~> 3.0.7'
gem 'high_voltage',     '~> 0.9'
gem 'hoptoad_notifier', '~> 2.4.2'
gem 'jquery-rails'
gem 'kaminari',         '~> 0.12.4'
gem 'compass',          '~> 0.11.1'
gem 'simple_form',      '~> 1.4.0'

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails',  '~> 2.6.0'
  gem 'ruby-debug19', '~> 0.11.6', :require => 'ruby-debug'
end

group :production, :staging do
  gem 'pg', '~> 0.10'
end

group :test do
  gem 'factory_girl_rails', '~> 1.0.1'
  gem 'bourne',             '~> 1.0'
  gem 'capybara',           :git => 'https://github.com/jnicklas/capybara.git'
  gem 'database_cleaner',   '~> 0.6.0'
  gem 'timecop',            '~> 0.3.5'
  gem 'email_spec',         '~> 1.1'
  gem 'valid_attribute'
  gem 'launchy'
  gem 'simple-rss',         '~> 1.2.3'
end
