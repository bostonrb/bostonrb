module MeetupsHelper

  def meetup_path meetup
    if !meetup.nil?
      link_to 'Sign up required', meetup.url, id: 'signup'
    end
  end

end
