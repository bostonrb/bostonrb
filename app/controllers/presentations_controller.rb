class PresentationsController < ApplicationController

  def index
    @presentations = Presentation.page(params[:page])
    @grouped_presentations = @presentations.group_by_date
  end
end
