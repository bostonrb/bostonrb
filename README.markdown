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
    
## Hosting

EngineYard is super awesome and provides us with a production environment. [Josh Nichols](http://github.com/technicalpickles) and [Dan Croak](http://github.com/dancroak) have access to it if any changes need to be deployed.
    
## Contributing

You should go through the steps lined out in 'Getting up and running'.

For bugs and features requests, we use GitHub Issues. You can see what is open here: http://github.com/bostonrb/bostonrb/issues

To contribute, you should fork on GitHub, make your changes, and then either comment on an existing issue pointing at your changes, or create a new issue if it's a new bug or feature.
    
## Contributors

Dan Croak, Josh Nichols, Harold Gimenez, Dan Pickett, Rebecca Frankel, Joe Ferris.

Design by Angelo Simeoni.