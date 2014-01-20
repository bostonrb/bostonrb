class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def is_organizer?
    current_user_permissions[:organizer]
  end

  def signed_in?
    !session[:user_session].nil?
  end

  def current_user_permissions
    session[:user_session]
  end
  helper_method :is_admin?, :signed_in?, :current_user

end
