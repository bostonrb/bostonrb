#
# The Event Class wraps the GCal4Ruby event into something 
# simpler as we don't need that much information about the
# event itself.
#
# @author Patrick Robertson
#
module BostonRbCalendar
  class Event
    attr_reader :title, :start_time, :end_time, :location
  
    def initialize(gcal_event)
      @title = gcal_event.title
      @start_time = gcal_event.start_time
      @end_time = gcal_event.end_time
      @location = gcal_event.where
    end
  end
end