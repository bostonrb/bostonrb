#
# The Event Class wraps the GCal4Ruby event into something 
# simpler as we don't need that much information about the
# event itself.
#
module BostonRbCalendar
  class Event
    attr_reader :title, :start_time, :end_time, :location, :url
  
    def initialize(gcal_event)
      @title = gcal_event["title"]["$t"]
      @start_time = DateTime.parse(gcal_event["gd$when"].first["startTime"])
      @end_time = DateTime.parse(gcal_event["gd$when"].first["endTime"])
      @location = gcal_event["gd$where"].first["valueString"]
      @url = gcal_event["link"].first["href"]
    end
  end
end