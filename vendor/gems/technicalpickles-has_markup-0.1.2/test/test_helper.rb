$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'

# Use vendored gem because of limited gem availability on runcoderun
# This is loosely based on 'vendor everything'.
Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', '**')].each do |dir| 
  lib = "#{dir}/lib"
  $LOAD_PATH.unshift(lib) if File.directory?(lib)
end

require 'test/unit'
require 'active_record'
require 'shoulda'
require 'shoulda/active_record'
require 'factory_girl'

RAILS_ROOT = File.dirname(__FILE__)
require 'logger'
RAILS_DEFAULT_LOGGER = Logger.new("#{RAILS_ROOT}/test.log") 

require File.dirname(__FILE__) + '/../init'
require File.dirname(__FILE__) + '/post.rb'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'plugin_test'])

load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")