# BostonRB [![travis-ci status](https://secure.travis-ci.org/bostonrb/bostonrb.png)](http://travis-ci.org/bostonrb/bostonrb)

This is the source code for the Boston Ruby Group's community website:

    http://bostonrb.org

It's a Rails app running [Ruby 1.9](http://www.ruby-lang.org/en/downloads) and uses:

* Postgres as a SQL database (SQLite for development)
* jQuery for client-side behavior
* Compass for stylesheets
* SimpleForm for forms
* Hoptoad for error notification
* High Voltage for static pages
* Capybara, RSpec, and VCR  for integration testing
* RSpec ad VCR for isolation testing
* ValidAttribute for model validation testing
* Factory Girl for test data

Setup
-----

If you want to make changes locally, follow these steps:

Install Ruby 1.9.3 (if necessary). RVM is optional, but highly recommended

    rvm install 1.9.3
    rvm use 1.9.3 --default

Install bundler

    gem install bundler

[Create your own fork](http://help.github.com/forking/) of the [bostonrb repository on github](https://github.com/bostonrb/bostonrb)

Clone your new fork

    git clone git@github.com:your-github-username/bostonrb.git
    cd bostonrb

For local development, install the required gems, minus the production and staging gemspecs

    bundle install --without production staging

Setup the development database (uses sqlite)

    cp config/database.example.yml config/database.yml
    rake db:create && rake db:migrate && rake db:seed

Run the tests

    rake

Compile all the assets

    rake assets:precompile

Run the server

    rails server

Deploy
------

The site is deployed to [Heroku](http://heroku.com) and takes advantage
of their Varnish layer by setting far future expires HTTP headers.

DataEntry
--------

Presentations can handle videos from [Vimeo](http://vimeo.com),
[Youtube](http://youtube.com), and [Blip.tv](http://blip.tv)

Just use the set the video_url attribute on the presentation to the
video's actual URL and everything is parsed.

The one exception is Blip.tv. You must use the src value from the
video's embed code instead of the video's URL.

Contributors
------------

This app is built and maintained by [members of the BostonRB community](https://github.com/bostonrb/bostonrb/contributors)
