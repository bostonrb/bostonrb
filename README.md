This is the source code for the Boston Ruby Group's community website:

    http://bostonrb.org

It's a Rails app running [Ruby 1.9](http://www.ruby-lang.org/en/downloads) and uses:

* Postgres as a SQL database
* jQuery for client-side behavior
* Sass and Flutie for stylesheets
* Formtastic for forms
* Hoptoad for error notification
* High Voltage for static pages
* Cucumber, Capybara, and Akephalos for integration testing
* RSpec for isolation testing
* Shoulda for RSpec matchers
* Factory Girl for test data

Setup
-----

If you want to make changes locally, follow these steps:

    git clone git@github.com:bostonrb/bostonrb.git
    bundle install
    rake db:create
    rake db:migrate
    rails s

Deploy
------

The site is deployed to [Heroku](http://heroku.com) and takes advantage
of their Varnish layer by setting far future expires HTTP headers.
