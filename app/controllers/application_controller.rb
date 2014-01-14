class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def is_organizer?
    session[:user_type] == 'organizer'
  end

  def signed_in?
    !session[:user_type].nil?
  end
  helper_method :is_admin?, :signed_in?

end
