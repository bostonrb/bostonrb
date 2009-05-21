module AppsHelper

  def app_links
    apps = App.all
    apps.collect { |app| link_to(app.name, app.homepage_url) }
  end

end
