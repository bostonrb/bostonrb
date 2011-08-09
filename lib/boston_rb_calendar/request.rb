#
# The Request Class retrieves the JSON from the
# BostonRB Calendar feed.
#
module BostonRbCalendar
  module Request

    protected

    def get_calendar_response
      calendar = BostonRbCalendar.config.calendar
      future_time = (Time.now.midnight + 1.month).xmlschema

      uri = URI::HTTP.new('http', nil, 'www.google.com', nil, nil, "/calendar/feeds/#{calendar}/public/composite?alt=json&futureevents=true&orderby=starttime&sortorder=a&ctz=America/New_York&fields=entry(title,link[@rel='alternate'],gd:where,gd:when[xs:dateTime(@startTime)<=xs:dateTime('#{future_time}')])", nil, nil, nil)

      http = Net::HTTP.new(uri.host,uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.initialize_http_header({"User-Agent" => "BostonRB"})

      http.request(request).body
    end

    def get_events_json
      json = ActiveSupport::JSON.decode get_calendar_response
      json["feed"]["entry"]
    end
  end
end
