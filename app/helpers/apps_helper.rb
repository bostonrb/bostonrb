module AppsHelper

  def sentence_of_linkable_apps
    apps = ["Hoptoad", "Umbrella Today", "Widgetfinger"]
    linkable_apps = apps.collect do |app|
      link_to app, "#"
    end
    linkable_apps.to_sentence
  end

end
