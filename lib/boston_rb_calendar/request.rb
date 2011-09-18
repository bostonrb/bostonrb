#
# The Request Class retrieves the JSON from the
# BostonRB Calendar feed.
#
module BostonRbCalendar
  module Request
    FETCH_EVENT_TIMEOUT = 5

    def get_events_json
      Timeout.timeout(FETCH_EVENT_TIMEOUT) do
        json = ActiveSupport::JSON.decode(get_calendar_response)
        json["feed"]["entry"]
      end
    rescue Timeout::Error => e
      Rails.logger.error("Timeout while fetching next calendar event: #{e.message}")
      []
    end

    private

    def get_calendar_response
      calendar = BostonRbCalendar.config.calendar
      future_time = (DateTime.current.midnight + 1.month + 5.days).xmlschema

      uri = URI::HTTP.new('http', nil, 'www.google.com', nil, nil, "/calendar/feeds/#{calendar}/public/composite?alt=json&singleevents=true&futureevents=true&orderby=starttime&sortorder=a&ctz=America/New_York&fields=entry(title,link[@rel='alternate'],gd:where,gd:when[xs:dateTime(@startTime)<=xs:dateTime('#{future_time}')])", nil, nil, nil)

      http = Net::HTTP.new(uri.host,uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.initialize_http_header({"User-Agent" => "BostonRB"})

      http.request(request).body
    end
  end
end
