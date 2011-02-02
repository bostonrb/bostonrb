require 'gcal4ruby'

##
# Hackity-hack hack for getting some calendar information onto the Boston.rb homepage.
# Since Boston.rb uses recurring events, GCal4Ruby is about the only library choice.
# You will need to set environment variables to a calendar account for this to function.
#
# @example Pull the next Boston.rb event
#   BostonRbCalendar.next_event
# @example Pull the next 3 Boston.rb events
#   BostonRbCalendar.upcoming_events
#
# @todo Write some frakkin tests
# @author Patrick Robertson (http://github.com/patricksrobertson)
##
module BostonRbCalendar
  
  # see http://docs.heroku.com/config-vars to setup stuff for local use.
  @auth_parameters = {
    :username => ENV['CALENDAR_USER'] || 'test.boston.rb@gmail.com',
    :password => ENV['CALENDAR_PASSWORD'] || 'ibetthisisapassword'
  }
  @calendar = ENV['BOSTON_CALENDAR'] || 'test.boston.rb%40gmail.com'
  
  def self.auth_parameters
    @auth_parameters
  end
  
  def self.auth_parameters=(params)
    @auth_parameters = params
  end
  
  def self.calendar 
    @calendar
  end
  
  def self.next_event
    upcoming_events.first
  rescue 
    nil
  end
  
  def self.upcoming_events
    authenticate
    filter_events(GCal4Ruby::Event.find(@@service,{'start-min' => Time.now.utc.xmlschema,
      'start-max' => (Time.now + 21.days).utc.xmlschema,
      'calendar_id' => @calendar
    }))
  rescue
    nil
  end
  
  
  private
  
  def self.filter_events(events)
    events.map{|e| e if e.calendar_id == @calendar}.compact.sort_by(&:start_time)
  rescue
    nil
  end    
  
  def self.authenticate
    @@service ||= GCal4Ruby::Service.new
    @@service.authenticate(@auth_parameters[:username],@auth_parameters[:password])
  end
end