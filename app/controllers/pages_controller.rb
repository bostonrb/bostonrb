class PagesController < ApplicationController

  # verify :params => :name, :only => :show, :redirect_to => :home_url
  before_filter :ensure_valid, :only => :show

  def show
    render :template => "pages/#{current_page}"
  end

  protected

    def current_page
      params[:name].to_s.downcase
    end

    def ensure_valid
      unless erb_exists?(current_page) || haml_exists?(current_page)
        render :nothing => true, :status => 404 and return false
      end
    end
  
    def erb_exists? page
      template_exists?("pages/#{page}.html.erb")
    end
  
    def haml_exists? page
      template_exists?("pages/#{page}.html.haml")
    end

end
