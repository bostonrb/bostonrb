require 'singleton'

#
# Configuration class for BostonRbCalendar.  This allows a
# configuration block to be used on an initializer.  Make sure
# to html escape that darn at sign.
#
# @example
#   BostonRbCalendar.configure do |config|
#     config.user_name = ENV['CALENDAR_USERNAME']
#     config.password = ENV['CALENDAR_PASSWORD']
#     config.calendar = ENV['CALENDAR']
#   end
#
module BostonRbCalendar
  class Configuration

    include Singleton

    @@defaults = { :calendar => 'admin%40bostonrb.org',
                   :cache => 3.hours }

    attr_accessor :cache, :calendar

    def self.defaults
      @@defaults
    end

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end
  end

  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end
end
