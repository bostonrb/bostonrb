require 'boston_rb_calendar/configuration'
require 'boston_rb_calendar/calendar_event'
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

  def self.cache_next_event
    Rails.cache.write(:next_event, next_event)
  end

  def self.next_event
    upcoming_events.first
  end

  def self.upcoming_events
    get_events_json.map do |event|
      CalendarEvent.new(event)
    end.select do |event|
      event.start_time
    end.sort_by(&:start_time)
  end
end
