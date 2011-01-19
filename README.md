This is the source code for the Boston Ruby Group's community website:

    http://bostonrb.org

It's a Rails app running [Ruby 1.9](http://www.ruby-lang.org/en/downloads).

Setup
-----

If you want to make changes locally, follow these steps:

    git clone git@github.com:bostonrb/bostonrb.git
    bundle install
    rails s

Deploy
------

The site is deployed to [Heroku](http://heroku.com) and takes advantage
of their Varnish layer by setting far future expires HTTP headers.
