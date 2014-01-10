class SessionsController < ApplicationController

  def create
    # sets the client for the Github API queries
    client = Octokit::Client.new :access_token => auth_hash['credentials']['token']

    @user ||= User.where(github_uid: auth_hash["uid"]).first
    if @user
      redirect_to root_path, notice: "Welcome back!"
    else
      @user = User.new(github_uid: auth_hash['uid'],name:auth_hash["info"]["nickname"])
      @user.save
      redirect_to root_path, notice: "You have successfully signed in!"
    end
    # For permenance, so the session knows it has a user signed in
    session[:current_user]=@user.id
    # sets the client for the Github API queries



    if client.team_member?(ENV['ORGANIZERS_TEAMID'], client.user.login)
      session[:user_type] = 'organizer'
    else
      session[:user_type] = 'project night coordinator' if client.team_member?(ENV['PROJECTNIGHT_TEAMID'], client.user.login)
    end
    binding.pry

  ## This is how to check if a member is part of BostonRB github
  # client.org_member?(ENV['BOSTONRB_NAME'], client.user.login)

  end

  def destroy
    self.current_user = nil
    session[:current_user]=nil
    redirect_to root_url, notice: "Signed out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
