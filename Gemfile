source :rubygems

gem "rails",                 "~> 3.0.3"
gem "pg",                    "~> 0.10"
gem "haml",                  "~> 3.0"
gem "high_voltage",          "~> 0.9"
gem "hoptoad_notifier",      "~> 2.4.2"
gem "formtastic",            "~> 1.2.3"
gem "dynamic_form",          "~> 1.1.3"
gem "validation_reflection", "~> 1.0.0"

# RSpec needs to be in :development group to expose generators
# and rake tasks without having to type RAILS_ENV=test.
group :development, :test do
  gem "rspec-rails",  "~> 2.4.0"
  gem "ruby-debug19", "~> 0.11.6"
end

group :test do
  gem "akephalos", :git => "git://github.com/thoughtbot/akephalos.git"

  gem "cucumber-rails",     "~> 0.3.2"
  gem "factory_girl_rails", "~> 1.0"
  gem "bourne",             "~> 1.0"
  gem "capybara",           "~> 0.3.9"
  gem "database_cleaner",   "~> 0.6.0"
  gem "sham_rack",          "~> 1.3.3"
  gem "timecop",            "~> 0.3.5"
  gem "shoulda",            "~> 2.11"
  gem "email_spec",         "~> 1.1"
end
