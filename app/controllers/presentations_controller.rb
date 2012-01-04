class PresentationsController < ApplicationController
  before_filter :redirect_if_upcoming, :only => [:index]

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

  private

  def redirect_if_upcoming
    if params[:upcoming]
      redirect_to month_presentations_path(:month => Presentation.next_upcoming_month)
    end
  end
end
