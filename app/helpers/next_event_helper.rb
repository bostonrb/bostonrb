module NextEventHelper
  def format_event(event)
    html = "#{event.title} <br/>".html_safe
    html << " #{start_time_format(event.start_time)} to #{end_time_format(event.end_time)} <br/>".html_safe
    html << " #{where_link(event.where)}".html_safe
  rescue
    "No event scheduled."
  end
  
  def start_time_format(time)
    time.strftime("%A, %B #{time.day.ordinalize}%l%p")
  end
  
  def end_time_format(time)
    time.strftime("%l%p")
  end
  
  def where_link(address)
    content_tag(:a, :href=>"http://maps.google.com/maps?q=#{address}") do
      address
    end
  end
end