module NextEventHelper
  def format_event_times(event)
    "#{start_time_format(event.start_time)} to #{end_time_format(event.end_time)}".html_safe
  end
  
  def start_time_format(time)
    time.strftime("%A, %B #{time.day.ordinalize}<br/>%l%p")
  end
  
  def end_time_format(time)
    time.strftime("%l%p")
  end
  
  def link_to_location(address)
    content_tag(:a, :href => "http://maps.google.com/maps?q=#{address}",
                :id => "event_location") do
      address
    end
  end
end