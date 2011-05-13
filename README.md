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

Install Ruby 1.9.2 (if necessary). RVM is optional, but highly recommended

    rvm install 1.9.2-p180
    rvm use 1.9.2 --default

Install the bundler gem

    gem install bundler

[Create your own fork](http://help.github.com/forking/) of the [bostonrb repository on github](https://github.com/bostonrb/bostonrb)

Clone your new fork

    git clone git@github.com:your-github-username/bostonrb.git
    cd bostonrb

Install the required gems

    bundle install

Setup the development database

    cp config/database.example.yml config/database.yml
    rake db:create db:migrate

Run the tests

    rake

Run the server

    rails s

Deploy
------

The site is deployed to [Heroku](http://heroku.com) and takes advantage
of their Varnish layer by setting far future expires HTTP headers.
