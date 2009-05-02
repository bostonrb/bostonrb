class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery # :secret => '7ed60f9b9e04d00c05d3d81aa2176e7c'

  include HoptoadNotifier::Catcher

  protected

  def protect_with_notacaptcha
    if failed_notacaptcha?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return
    end
  end

  def failed_notacaptcha?
    ! params[:captcha].blank?
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session
end
