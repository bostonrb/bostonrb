class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.past(:page => params[:page], :per => params[:per])
    @grouped_presentations = @presentations.group_by_date

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @presentations = Presentation.where(:id => params[:id]).page(nil)
    @grouped_presentations = @presentations.group_by_date
    render :action => :index
  end
end
