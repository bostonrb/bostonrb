require 'rake'
require 'rake/testtask'

test_files_pattern = 'test/twitter_*_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = false
end

desc "Run the test suite"
task :default => :test

gem_spec = Gem::Specification.new do |gem_spec|
  gem_spec.name        = "twitter-search"
  gem_spec.version     = "0.5.3"
  gem_spec.summary     = "Ruby client for Twitter Search."
  gem_spec.email       = "dcroak@thoughtbot.com"
  gem_spec.homepage    = "http://github.com/dancroak/twitter-search"
  gem_spec.description = "Ruby client for Twitter Search."
  gem_spec.authors     = ["Dustin Sallings", "Dan Croak", "Luke Francl", "Matt Sanford", "Alejandro Crosa", "Danny Burkes", "Don Brown", "HotFusionMan"]
  gem_spec.files       = FileList["[A-Z]*", "{generators,lib,shoulda_macros,rails}/**/*"]
  gem_spec.add_dependency('json', '>= 1.1.2')
end

desc "Generate a gemspec file"
task :gemspec do
  File.open("#{gem_spec.name}.gemspec", 'w') do |f|
    f.write gem_spec.to_yaml
  end
end

require File.expand_path('lib/twitter_search', File.dirname(__FILE__))
require 'rubygems'
require 'yaml'

namespace :yaml do
  desc "Write Twitter Search results to yaml file so API is not hit every test."
  task :write do
    write_yaml :tweets => 'Obama',                                     :file => 'obama'
    write_yaml :tweets => 'twitter search',                            :file => 'twitter_search'
    write_yaml :tweets => {:q => 'twitter search'},                    :file => 'twitter_search_and'
    write_yaml :tweets => {:q => '"happy hour"'},                      :file => 'happy_hour_exact'  
    write_yaml :tweets => {:q => 'obama OR hillary'},                  :file => 'obama_or_hillary'
    write_yaml :tweets => {:q => 'beer -root'},                        :file => 'beer_minus_root'
    write_yaml :tweets => {:q => '#haiku'},                            :file => 'hashtag_haiku'
    write_yaml :tweets => {:q => 'from:alexiskold'},                   :file => 'from_alexiskold'
    write_yaml :tweets => {:q => 'to:techcrunch'},                     :file => 'to_techcrunch'
    write_yaml :tweets => {:q => '@mashable'},                         :file => 'reference_mashable'
    write_yaml :tweets => {:q => '"happy hour" near:"san francisco"'}, :file => 'happy_hour_near_sf'
    write_yaml :tweets => {:q => 'near:NYC within:15mi'},              :file => 'within_15mi_nyc'
    write_yaml :tweets => {:q => 'superhero since:2008-05-01'},        :file => 'superhero_since'
    write_yaml :tweets => {:q => 'ftw until:2008-05-03'},              :file => 'ftw_until'
    write_yaml :tweets => {:q => 'movie -scary :)'},                   :file => 'movie_positive_tude'
    write_yaml :tweets => {:q => 'flight :('},                         :file => 'flight_negative_tude'
    write_yaml :tweets => {:q => 'traffic ?'},                         :file => 'traffic_question'
    write_yaml :tweets => {:q => 'hilarious filter:links'},            :file => 'hilarious_links'
    write_yaml :tweets => {:q => 'congratulations', :lang => 'en'},    :file => 'english'
    write_yaml :tweets => {:q => 'با', :lang => 'ar'},                 :file => 'arabic'
    write_yaml :tweets => {:q => 'Boston Celtics', :rpp => '30'},      :file => 'results_per_page'
  end
end

def write_yaml(opts = {})
  @client = TwitterSearch::Client.new 'twitter-search'
  tweets  = @client.query(opts[:tweets])
  File.open(File.join(File.dirname(__FILE__), 'test', 'yaml', "#{opts[:file]}.yaml"), 'w+') do |file| 
    file.puts tweets.to_yaml
  end
end
