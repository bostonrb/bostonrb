# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def blueprint_ie
    html = "<!--[if IE]>"
    html << stylesheet_link_tag('/blueprint/ie', :media => 'screen')
    html << "<![endif]-->"
    html
  end
  
  def tab_link_attributes(name)
    attributes = {}
    attributes[:class] = 'current' if controller.controller_name == name
    attributes
  end
  
  def tab_for(name, url = nil)
    url ||= send("#{name.downcase}_url")
    "<li>#{link_to name.capitalize, url, tab_link_attributes(name)}</li>"
  end
end
