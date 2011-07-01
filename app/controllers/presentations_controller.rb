class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.past_or_by_month(:page => params[:page], :per => params[:per], :month => params[:month])
    @grouped_presentations = @presentations.group_by_date

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @presentations = Presentation.find_all_by_cached_slug_or_id(params[:id]).page(nil)
    @grouped_presentations = @presentations.group_by_date
  end
end
