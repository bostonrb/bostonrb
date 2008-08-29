class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7ed60f9b9e04d00c05d3d81aa2176e7c'
  
  protected
    def protect_with_notacaptcha
      unless params[:captcha].blank?
        render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return
      end
    end
end
