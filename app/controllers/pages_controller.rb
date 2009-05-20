class PagesController < ApplicationController

  before_filter :ensure_valid

  def show
    render :template => current_page
  end

  protected

  def current_page
    "pages/#{params[:id].to_s.downcase}"
  end

  def ensure_valid
    unless template_exists?(current_page)
      render :nothing => true, :status => :not_found and return false
    end
  end

  def template_exists?(path)
    self.view_paths.find_template(path, response.template.template_format)
  rescue ActionView::MissingTemplate
    false
  end

end
