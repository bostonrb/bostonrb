class SessionsController < ApplicationController

  def create
    # sets the client for the Github API queries
    client = GithubAuth.new(auth_hash, Octokit::Client)
    # Redirects the user to the home page if they're not a BostonRB member
    if client.is_member? == false
      redirect_to root_url, notice: 'Not a valid user. Must be a member of BostonRB github to sign in.'
      return
    end

    # Sets a session user_type if they're members of organizer or project night coordinators.
    session[:user_type] = client.assign_team

    redirect_to root_url, notice: 'Signed in!'
  end

  def failed
    redirect_to root_path, notice: "Authentication Failed"
  end

  def destroy
    session[:user_type] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
