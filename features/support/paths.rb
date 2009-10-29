module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the homepage/i
      root_path
    when /the sign up page/i
      new_user_path
    when /the sign in page/i
      new_session_path
    when /the password reset request page/i
      new_password_path
    when /the events page/i
      events_path
    when /the events atom feed/i
      events_path :format => :atom
    when /the events rss feed/i
      events_path :format => :rss
    when /the presentation's page/i
      presentation_path(@presentation)
    when /new presentation page/i
      new_presentation_path
    when /the jobs atom feed/i
      jobs_path :format => :atom
    # Add more page name => path mappings here

    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)
