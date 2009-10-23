# Boston.rb

This is the source code for the Boston Ruby Group website, [bostonrb.org](http://bostonrb.org).

It is licensed under the MIT License, so if you would like to fork and customize for your own user group, you are more than welcome to.

## Getting up and running

### Requirements

bostonrb.org is built and managed primarily the following:

 * Ruby 1.8.x
 * Rubygems 1.3.5
 * Ruby on Rails 2.3.4
 * MySQL
 * git
 
You will need these installed before you can start developing and running the application. For help getting this environment running, see [these excellent installation notes](http://wiki.devchix.com/index.php?title=Workshop_Installation_Notes)

### Configuring RubyGems

Since we use some gems that are only on github (ie feedzirra), this needs to be run, if you haven't before:

    gem sources -a http://gems.github.com

### Downloading

We're using GitHub for our git hosting. To download the source, use the following command:

    git clone git://github.com/bostonrb/bostonrb.git
    
### Initial setup

Before anything else, change into the newly created `bostonrb` directory.

    cd bostonrb

We need to make sure all the gem dependencies are installed:

    rake gems:install
    rake gems:install RAILS_ENV=test

Now we need to create an initial database. We currently assume you have MySQL installed, and that you can login as 'root' without a password.

    rake db:create
    
Next migrate the database to the latest version:

    rake db:migrate
    
At last, we can run the server:

    script/server

This will keep running until you hit Control-C, but now you can open a browser and go to http://localhost:3000 to see the app running.

You'll notice the site is kind of... empty. You can generate a bit of seed data with:

    rake db:bootstrap

## Testing

We are using shoulda for our testing. Before running them, you need to run the following to create the test database:

    rake db:create RAILS_ENV=test
    
At this point, you can run them with:

    rake test
    
We are also using cucumber for user stories / integration testing. You can run them with:

    rake features
    
## Regular scheduled tasks

Tweets and blog posts are regularly updated, based on the users in the system. You can run the following to make them update in development:

    rake get_tweets
    rake get_blogs

For our EY deployment, there's a custom wrapper to handle logging output at  /engineyard/custom/cron_wrapper, which among other things, adds logging to /data/bostonrb/current/logs. It takes four arguments: the application to run for (always will be bostonrb), the name of the log file, the rails environment, and lastly the command to run

The current crontab entries look like:

    */5 * * * * /engineyard/custom/cron_wrapper bostonrb get_tweets production 'rake get_tweets'
    */5 * * * * /engineyard/custom/cron_wrapper bostonrb get_blogs production 'rake get_blogs'

## Tools and libraries used

Here is a list, in no particular order, of the libraries and other tools used, and how or why we're using them.
    
### [RedCloth](http://redcloth.org/)

Library for generating HTML from [textile](http://redcloth.org/textile) markup. We use this so we don't have to have users enter HTML for descriptions of jobs, events, etc

### BlueCloth

Library for generating HTML from [markdown](http://daringfireball.net/projects/markdown/) markup. We use this so we don't have to have users enter HTML for descriptions of jobs, events, etc

### le-git

A library by Josh Nichols and Dan Croak to access the [GitHub API](http://develop.github.com/). Users enter their GitHub username when setting up an account, and we use le-git to aggregate them.

### twitter-search

A library by Dan Croak to access the [Twitter Search API](http://apiwiki.twitter.com/Twitter-API-Documentation). Users enter their Twitter usernames when setting up an account, and we use twitter-search to aggregate them.

### fakeweb

A test library that lets you intercept network connections setup by [net/http], and setup canned responses for them.

We use this to make sure no network connections happen during testing.

### feedra

A library by Josh Nichols that lets you easily setup add feed aggregation to a Rails app.

We use this to let users and companies enter the URL of their blog feed, so we can aggregate it.

### gravtastic

A library for interacting with [gravatar](http://en.gravatar.com/). 

We use this to display user gravatars on the front page.

### haml

### mocha

### inherited_resources

### has_markup

### clearance

### factory_girl

### pacecar

### shoulda

### truncate_html

An extension to ActionView written by Harold Gimenez to truncate

### will_paginate

An extension to ActiveRecord to allow for easily pagination of queries.

We usually use this on index pages, where we want to show several smaller pages of results, rather than one extremely long one.

### bootstrapper

### fast_random

An extension to ActiveRecord written by Harold Gimenez to provide a database asgnostic named_scope to get a random record.

We use this to 

### geokit

A library which can geocode an address into a latitude and longitude. We use this geocode the addresses of our events, so we can display a Google map to them in combination with Google Maps 

### hoptoad_notifier

### validates_email_format_of

A plugin to add an ActiveRecord validation method for emails. This is used to validate a user's email address.

### validates_url_format_of

A plugin to add an ActiveRecord validation method for URLs. This is used to validate a user's website URL.

## Hosting

EngineYard is super awesome and provides us with a production environment. [Josh Nichols](http://github.com/technicalpickles) and [Dan Croak](http://github.com/dancroak) have access to it if any changes need to be deployed.
    
## Contributing

You should go through the steps lined out in 'Getting up and running'.

For bugs and features requests, we use GitHub Issues. You can see what is open here: http://github.com/bostonrb/bostonrb/issues

To contribute, you should fork on GitHub, make your changes, and then either comment on an existing issue pointing at your changes, or create a new issue if it's a new bug or feature.
    
## Contributors

Dan Croak, Josh Nichols, Harold Gimenez, Dan Pickett, Rebecca Frankel, Joe Ferris.

Design by Angelo Simeoni.
