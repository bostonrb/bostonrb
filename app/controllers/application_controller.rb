class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def is_organizer?
    session['organizer']
  end

  def signed_in?
    session['organizer'] || session['project_night_coordinator']
  end

  helper_method :is_organizer?, :signed_in?

end
