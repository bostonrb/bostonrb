HasFinder is an extension to ActiveRecord that makes it easier than ever to create custom find and count queries.

Let's start with an example. Suppose you have an Article model; some articles are published, some are popular. Let's declare finders for each of these notions. You may be tempted to write something like the following:

    class Article < ActiveRecord::Base
      def self.published
        find(:all, :conditions => {:published => true})
      end
  
      def self.popular
        ...
      end
      ...
    end

But there are serious limitations to this approach. How do you find articles that are BOTH popular and published? How can you easily paginate published articles?

# HasFinder Features

Let's define the equivalent finders using my new plugin, has_finder:

    class Article < ActiveRecord::Base
      has_finder :published, :conditions => {:published => true}
      has_finder :popular, :conditions => ...
    end

## Query Composition

Now, you can elegantly compose queries:

    Article.published.popular
    
This will return all articles that are both popular and published. 

## Calculations and Nested Finds
You can also easily paginate or call nested finders or do calculations:

    Article.published.paginate(:page => 1)
    Article.published.popular.count
    Article.popular.find(:first)
    Article.popular.find(:all, :conditions => {...})

## Works with ActiveRecord `has_many` and `has_many :through` Associations
Furthermore, without any additional work, these finders will work with ActiveRecord associations.

    class User
      has_many :articles
    end

    user.articles.popular.find(:first)
    user.articles.published.popular.average(:view_count)

## Finders are extendable just like ActiveRecord Associations

    class Article
      has_finder :unpublished :conditions => {:published => false} do
        def published_all
          find(:all).map(&:publish)
        end
      end
    end

Alternatively, you can use the :extend options:

    class Article
      has_finder :unpublished, :conditions => ..., :extend => MyExtensionModule
    end

## Finders behave just like ActiveRecord Associations

For example, you can call #reload:

    Article.published.popular.reload

## Finders can take parameters

    class Car
      has_finder :colored, lambda {|color| { :conditions => {:color => color} } }
    end

    Car.colored('red').paginate(:page => 1)

# What makes HasFinder better than alternatives like `scope_out` and `scoped_proxy`?

There are already two plugins similar to HasFinder: [`scope_out`](http://code.google.com/p/scope-out-rails) and [`scoped_proxy`](http://www.neotrivium.com/blog/2007/4/4/out_of_the_scope_of_scope_out?language=en-US). Both of them are excellent. In fact, Scoped Proxy was the model for HasFinder. Unfortunately, neither plugin provided all of the features I desired. Scope-Out lacks on-the-fly composition, a nice way to call a nested find, or the ability to do arbitrary calculations. Scoped Proxy is great, but it doesn't work with regular ActiveRecord Associations, it is not extendable like ActiveRecord associations, and it doesn't behave exactly like a regular ActiveRecord Association. Neither of them work out of the box with will_paginate. For all of these reasons and more, I rolled my own. It's now available as a gem.

# Installation

    % gem install has_finder

# Usage

In environment.rb:

    gem 'has_finder'
    require 'has_finder'
    
See the examples above for usage.