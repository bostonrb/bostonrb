class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include HoptoadNotifier::Catcher
  include Clearance::Authentication

  before_filter :authenticate,
    :only => [:new, :create, :edit, :update, :destroy]

  protected

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session
end
