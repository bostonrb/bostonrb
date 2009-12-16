require 'rubygems'

require 'action_controller'
require 'action_controller/test_process'
require 'active_record'
require 'active_record/base'
require 'active_support'

require 'active_support/test_case'

Dir.glob(File.join(File.dirname(__FILE__), "..", "lib", "scaler", "*.rb")).each {|f| require f }

require 'test/unit'