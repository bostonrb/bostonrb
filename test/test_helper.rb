ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require File.expand_path(File.dirname(__FILE__) + '/helper_testcase')

Dir[File.join(RAILS_ROOT, 'test', 'factories', '*')].each do |file|
  require file
end

begin require 'redgreen'; rescue LoadError; end

# require 'factory_girl'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # self.backtrace_silencers << :rails_vendor
  self.backtrace_filters   << :rails_root
  
  # Factory.define do |factory|
  #   factory.add :project do |project|
  #     project.name          {'recommendable'}
  #     project.homepage_url  {'http://github.com/dancroak/recommendable/tree/master'}
  #     project.feed_url      {'http://github.com/feeds/dancroak/commits/recommendable/master'}
  #     project.description   {'A Rails plugin for Amazon.com-style item-to-item collaborative filtering.'}
  #   end
  #   
  #   factory.add :job, :fulltime do |job|
  #     job.location          {'Boston, MA'}
  #     job.organization      {'thoughtbot'}
  #     job.title             {'Rails developer'}
  #     job.description       {'Full time stuff'}
  #     job.gig               {false}
  #   end
  #   
  #   factory.add :job, :gig do |job|
  #     job.location          {'Boston, MA'}
  #     job.organization      {'thoughtbot'}
  #     job.title             {'Rails developer'}
  #     job.description       {'Full time stuff'}
  #     job.gig               {true}
  #   end
  # 
  #   factory.add :event do |event|
  #     event.event_type      {'Hackfest'}
  #     event.date            {Time.now}
  #     event.description     {'a cool hackfest'}
  #   end
  #   
  #   factory.add :event, :hackfest do |event|
  #     event.event_type      {'Hackfest'}
  #     event.date            {Time.now}
  #     event.description     {'a cool hackfest'}
  #   end
  #   
  #   factory.add :video do |video|
  #     video.title           {'Shoulda tutorial'}
  #     video.presenter       {'Tammer Saleh'}
  #     video.source          {'Some crazy conference'}
  #     video.url             {'http://video.google.com'}
  #   end
  #   
  #   factory.add :commit do |commit|
  #     commit.title          {'Messing with git configs, updating README to declare "alpha" status.'}
  #     commit.url            {'http://github.com/dancroak/recommendable/commit/51bac8797bcc33b77790a822b4fcaa4edf844e86'}
  #     commit.published_at   {DateTime.now}
  #     commit.project        {Factory.build_project}
  #   end
  # end
  # include FactoryMixin
  # 
  def file_fixture(name)
    File.read(File.join(File.dirname(__FILE__), "file_fixtures", name))
  end
  
  include FixtureReplacement
  
  # include Factories
end
