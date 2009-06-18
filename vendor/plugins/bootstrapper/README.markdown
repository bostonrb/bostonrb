Bootstrapper
============

  A rather simple plugin that executes a block to load seed/bootstrap data
  into a database.


Example
=======

  Run the bootstrapper generator:

    ruby script/generate bootstrapper

  This will place a bootstrap.rb file in the db directory within your project.

  The file will have something like this in it:

    Bootstrapper.for :development do |b|
    end

    Bootstrapper.for :production do |b|
    end

    Bootstrapper.for :test do |b|
    end

    Bootstrapper.for :staging do |b|
    end

  Using things like Factory Girl and Forgery you can quickly and easily
  generate fake, random, and/or seed data.

  An example using Factory Girl:

    Bootstrapper.for :development do |b|
      b.truncate_tables :addresses
      b.run :users

      Factory(:us_address, :state => "ME")
      Factory(:us_address, :state => "IL")
      Factory(:us_address, :state => "CA")
    end

    Bootstrapper.for :production do |b|
    end

    Bootstrapper.for :test do |b|
    end

    Bootstrapper.for :staging do |b|
    end

    Bootstrapper.for :users do |b|
      3.times{ Factory(:user) }
      Factory(:user, :login => "admin",
                     :password => "sekret",
                     :password_confirmation => "sekret")
    end

  With that file, you could run:

    rake db:bootstrap

  Which will run the development (default) bootstrap.  You can specify which
  bootstrap task to run by specifying:

    rake db:bootstrap BOOTSTRAP=users

  You can also run bootstrap for another environment:

    rake db:bootstrap RAILS_ENV=production

  You can even run a specific bootstrap for another environment:

    rake db:bootstrap BOOTSTRAP=users RAILS_ENV=production

  The variable passed into a Bootstrapper block is actually Bootstrapper
  itself, so you can use any methods it has.

  You can delete all records from tables using 'truncate_tables':

    b.truncate_tables :users
    b.truncate_tables :users, :addresses

  You can run other bootstrap tasks using 'run':

    b.run :users
    b.run :production

FactoryGirl [http://github.com/thoughtbot/factory_girl/tree/master](http://github.com/thoughtbot/factory_girl/tree/master)

Forgery [http://github.com/sevenwire/forgery/tree/master](http://github.com/sevenwire/forgery/tree/master)

Copyright (c) 2008 Sevenwire, released under the MIT license
