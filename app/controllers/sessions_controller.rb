class SessionsController < ApplicationController

  def create
    # sets the client for the Github API queries
    client = Octokit::Client.new :access_token => auth_hash['credentials']['token']

    # Redirects the user to the home page if they're not a BostonRB member
    if client.org_member?(ENV['BOSTONRB_NAME'], client.user.login) == false
      redirect_to root_url, notice: 'Not a valid user. Must be a member of BostonRB github to sign in.'
    end

    # Sets a session user_type if they're members of organizer or project night coordinators.
    if client.team_member?(ENV['ORGANIZERS_TEAMID'], client.user.login)
      session[:user_type] = 'organizer'
    elsif client.team_member?(ENV['PROJECTNIGHT_TEAMID'], client.user.login)
      session[:user_type] = 'project night coordinator'
    end
    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_type]=nil
    redirect_to root_url, notice: "Signed out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
