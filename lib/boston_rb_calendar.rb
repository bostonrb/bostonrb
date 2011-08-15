require 'boston_rb_calendar/configuration'
require 'boston_rb_calendar/event'
require 'boston_rb_calendar/request'

#
# Module that pulls the most recent Google Calendar Event from the BostonRB account.
# Since Boston.rb uses recurring events, GCal4Ruby is about the only library choice.
# You will need to set environment variables to a calendar account for this to function.
#
# @example Pull the next Boston.rb event
#   BostonRbCalendar.next_event
#
module BostonRbCalendar
  extend Request

  def self.next_event
    upcoming_events.first
  end

  def self.upcoming_events
    get_events_json.map { |e| Event.new(e) }.sort_by(&:start_time)
  end
end
