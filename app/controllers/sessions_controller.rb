class SessionsController < ApplicationController

  def create
    client = GithubAuth.new(auth_hash, Octokit::Client)

    # Redirects the user to the home page if they're not a BostonRB member
    if client.is_member? == false
      redirect_to root_url, notice: 'Not a valid user. Must be a member of BostonRB github to sign in.'
      return nil
    end

    session.merge!(client.to_hash)

    redirect_to root_url, notice: 'Signed in!'
  end

  def failed
    redirect_to root_path, notice: "Authentication Failed"
  end

  def destroy
    session[:user_session] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
