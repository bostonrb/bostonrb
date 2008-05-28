module EventsHelper
  
  def event_type_and_date(event)
    link_to "#{event.event_type}: #{event.date.to_s(:european)}", edit_event_path(event)
  end
  
  def event_map(event)
    unless event.nil? || !event.geocoded?
      map = GMap.new 'map'
      map.control_init
      map.center_zoom_on_points_init event.lat_lng_pair
      map.overlay_init GMarker.new(event.lat_lng_pair) 
      
      html = GMap.header
      html << map.to_html
      html
	  end
  end
  
end
