class GithubAuth

  def initialize(auth_hash, client_class)
    @client = client_class.new :access_token => auth_hash['credentials']['token']
  end

  def is_member?
    if @client.org_member?(ENV['BOSTONRB_NAME'], @client.user.login) == false
      binding.pry
      true
    end
  end

  def assign_team
    if @client.team_member?(ENV['ORGANIZERS_TEAMID'], @client.user.login)
      'organizer'
    elsif @client.team_member?(ENV['PROJECTNIGHT_TEAMID'], @client.user.login)
      'project night coordinator'
    end
  end

end
