# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def blueprint_ie
    html = "<!--[if IE]>"
    html << stylesheet_link_tag('/blueprint/ie', :media => 'screen')
    html << "<![endif]-->"
    html
  end
  
  def next_event
    event = Event.next
    unless event.nil?
      html =  '<div id="next_event_banner"><marquee>'
      html << "Next event &#187; "
      html << "#{event.title} &#187; "
      html << event.date.to_s(:european)
      html << '</marquee></div>'
      html
    end
  end
  
  def tab_link_attributes(name)
    attributes = {}
    attributes[:class] = 'current' if controller.controller_name == name
    attributes
  end
  
  def tab_for(name)
    "<li>#{link_to name.capitalize, send("#{name.downcase}_url"), tab_link_attributes(name)}</li>"
  end
end
