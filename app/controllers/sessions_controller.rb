class SessionsController < ApplicationController

  def create
    # @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    # redirect_to root_path, notice:'You have successfully signed in!'
    @user ||= User.where(github_uid: auth_hash["uid"]).first
    if @user
      redirect_to root_path, notice: "Welcome back!"
    else
      @user = User.new(github_uid: auth_hash['uid'],name:auth_hash["info"]["nickname"])
      @user.save
      redirect_to root_path, notice: "You have successfully signed in!"
    end
    session[:current_user]=@user.id
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
