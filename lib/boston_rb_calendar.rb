require 'gcal4ruby'

require 'boston_rb_calendar/configuration'
require 'boston_rb_calendar/event'

#
# Module that pulls the most recent Google Calendar Event from the BostonRB account.
# Since Boston.rb uses recurring events, GCal4Ruby is about the only library choice.
# You will need to set environment variables to a calendar account for this to function.
#
# @example Pull the next Boston.rb event
#   BostonRbCalendar.next_event
#
# @author Patrick Robertson
#
module BostonRbCalendar
  
  def self.next_event
    authenticate
    query = {
      'singleevents' => true,
      'orderby' => 'starttime',
      :calendar => BostonRbCalendar.config.calendar,
      'sortorder' => 'ascending',
      'start-min' => Time.now.xmlschema,
      'start-max' => (Time.now + 1.month).xmlschema,
      'max-results' => '1'
    }

    Event.new GCal4Ruby::Event.find(calendar_service,'',query).first
  end

  protected
  
  def self.authenticate
    calendar_service.authenticate(BostonRbCalendar.config.user_name,BostonRbCalendar.config.password)
  end

  def self.calendar_service
    @service ||= GCal4Ruby::Service.new
  end
end