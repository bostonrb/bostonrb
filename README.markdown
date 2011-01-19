# Boston.rb

This is the source code for the Boston Ruby Group website, [bostonrb.org](http://bostonrb.org).

It is licensed under the MIT License, so if you would like to fork and customize for your own user group, you are more than welcome to.

## Getting up and running

### Requirements

bostonrb.org is built and managed primarily the following:

 * Ruby 1.8.x
 * Rubygems 1.3.5
 * Ruby on Rails 3.x
 * MySQL
 * git

You will need these installed before you can start developing and running the application. For help getting this environment running, see [these excellent installation notes](http://wiki.devchix.com/index.php?title=Workshop_Installation_Notes)

(You can try Google for documentation on MySQL installation for your operating system.)

### Configure RVM and project gemset (RVM is optional, but recommended)

If necessary install Ruby 1.8.7

    rvm install 1.8.7-p249

Create a gemset to minimize gem conflicts

    rvm --create 1.8.7-p249@bostonrb

Make sure you use Ruby 1.8.7 and the bostonrb gemset in every terminal

    rvm use 1.8.7-p249@bostonrb

### Configuring RubyGems

Since we use some gems that are only on github (ie feedzirra), this needs to be run, if you haven't before:

    gem sources -a http://gems.github.com

### Downloading

We're using GitHub for our git hosting. To download the source, use the following command:

    git clone git://github.com/bostonrb/bostonrb.git

### Contributing

You should go through the steps lined out in 'Getting up and running'.

For bugs and features requests, we use GitHub Issues. You can see what is open here: http://github.com/bostonrb/bostonrb/issues

To contribute, you should fork on GitHub, make your changes, and then either comment on an existing issue pointing at your changes, or create a new issue if it's a new bug or feature.

## Contributors

Dan Croak, Josh Nichols, Harold Gimenez, Dan Pickett, Rebecca Frankel, Joe Ferris, Greg Sterndale.

Design by Chad Mazzola.
