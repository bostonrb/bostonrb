class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def is_organizer?
    session['organizer']
  end

  def signed_in?
    session['organizer'] || session['project_night_coordinator']
  end

  def check_for_organizer
    raise ActionController::RoutingError.new('Not Found') unless is_organizer?
  end

  helper_method :is_organizer?, :signed_in?, :check_for_organizer

end
