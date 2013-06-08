module MeetupsHelper

  def project_night_link_path meetup
    if !meetup.nil?
      link_to 'Sign up required', meetup.project_night_url, id: 'signup'
    end
  end

  def meeting_link_path meetup
    if !meetup.nil?
      link_to 'Sign up required', meetup.meeting_url, id: 'signup'
    end
  end

end
