module AppsHelper

  def app_links
    apps = ["Hoptoad", "Umbrella Today", "Widgetfinger"]
    apps.collect { |app| link_to(app, "#") }
  end

end
