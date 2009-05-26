#!/usr/bin/env ruby

desc "Get the latest Tweets by Boston Rubyists"
task :get_tweets => :environment do
  Cron.get_tweets
end

desc "Get the latest Blog Posts by Boston Rubyists"
task :get_blogs => :environment do
  Feed.fetch_stale!
end

desc "Get the latest Github Projects by Boston Rubyists"
task :get_projects => :environment do
  Cron.get_projects
end
