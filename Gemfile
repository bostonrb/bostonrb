source :rubygems

gem "rails",                 "~> 3.0.7"
gem "sass"
gem "high_voltage",          "~> 0.9"
gem "flutie",                "~> 1.1"
gem "hoptoad_notifier",      "~> 2.4.2"
gem "formtastic",            "~> 1.2.3"
gem "dynamic_form",          "~> 1.1.3"
gem "validation_reflection", "~> 1.0.0"
gem "jquery-rails"

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem "sqlite3"
  gem "rspec-rails",  "~> 2.6.0"
  gem "ruby-debug19", "~> 0.11.6"
end

group :production, :staging do
  gem "pg", "~> 0.10"
end

group :test do
  gem "cucumber-rails",     "~> 0.4.1"
  gem "factory_girl_rails", "~> 1.0.1"
  gem "bourne",             "~> 1.0"
  gem "capybara",           "~> 0.4.1.2"
  gem "database_cleaner",   "~> 0.6.0"
  gem "sham_rack",          "~> 1.3.3"
  gem "timecop",            "~> 0.3.5"
  gem "shoulda",            "~> 2.11"
  gem "email_spec",         "~> 1.1"
  gem 'valid_attribute'
end
