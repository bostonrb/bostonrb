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
    Rails.cache.fetch(:next_event, :expires_in => BostonRbCalendar.config.cache) do
      upcoming_events.first
    end
  end

  def self.upcoming_events
    events = []
    raw_events = get_events_json
    raw_events.each do |event|
      events << Event.new(event)
    end

    events.sort_by{ |event| event.start_time }
  end
end
