require 'gcal4ruby'
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
    upcoming_events.first
  end
  
  def self.upcoming_events
    xml = get_events_xml
    events = []
    service = GCal4Ruby::Service.new
    
    xml.root.elements.each("entry") do |e|
      ele = GData4Ruby::Utils::add_namespaces(e)
      event = GCal4Ruby::Event.new(service)
      event.load(ele.to_s) 
      events << Event.new(event)
    end
    
    events    
  end
  
  protected
  
  def self.get_events_xml
    REXML::Document.new get_calendar_response
  end
  
  def self.get_calendar_response
    uri = URI::HTTP.new('http', nil, 'www.google.com', nil, nil, "/calendar/feeds/admin%40bostonrb.org/public/composite?futureevents=true&orderby=starttime&sortorder=a&ctz=America/New_York&fields=entry(title,link[@rel='alternate'],gd:where,gd:when[xs:dateTime(@startTime)<=xs:dateTime('2011-09-06T19:00:00.000-04:00')])", nil, nil, nil)

    http = Net::HTTP.new(uri.host,uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "BostonRB"})
    
    http.request(request).body
  end
  
end