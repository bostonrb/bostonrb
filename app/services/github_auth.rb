class GithubAuth

  def initialize(auth_hash, client_class)
    @client = client_class.new :access_token => auth_hash['credentials']['token']
  end

  def is_member?
    if @client.org_member?(ENV['BOSTONRB_NAME'], @client.user.login)
      true
    end
  end

  def is_organizer?
    @client.team_member?(ENV['ORGANIZERS_TEAM_ID'], @client.user.login)
  end

  def is_project_night_coordinator?
    @client.team_member?(ENV['PROJECTNIGHT_TEAM_ID'], @client.user.login)
  end

  def to_hash
    {organizer: is_organizer?,
    project_night_coordinator: is_project_night_coordinator?}
  end

end
