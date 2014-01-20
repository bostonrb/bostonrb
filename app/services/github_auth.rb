class GithubAuth

  def initialize(auth_hash, client_class)
    @client = client_class.new :access_token => auth_hash['credentials']['token']
  end

  def is_member?
    if @client.org_member?(ENV['BOSTONRB_NAME'], @client.user.login)
      true
    end
  end

  def return_team_assignment
    if @client.team_member?(ENV['ORGANIZERS_TEAM_ID'], @client.user.login)
      'organizer'
    elsif @client.team_member?(ENV['PROJECTNIGHT_TEAM_ID'], @client.user.login)
      'project night coordinator'
    end
  end

end
