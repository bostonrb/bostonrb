ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require File.expand_path(File.dirname(__FILE__) + '/helper_testcase')

Dir[File.join(RAILS_ROOT, 'test', 'factories', '*')].each do |file|
  require file
end

begin require 'redgreen'; rescue LoadError; end

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # self.backtrace_silencers << :rails_vendor
  self.backtrace_filters   << :rails_root
  
  def file_fixture(name)
    File.read(File.join(File.dirname(__FILE__), "file_fixtures", name))
  end
  
  include FixtureReplacement
end
