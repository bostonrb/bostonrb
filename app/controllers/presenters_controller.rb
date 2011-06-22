class PresentersController < ApplicationController
  def show
    @presenter = Presenter.find(params[:id])
    @grouped_presentations = @presenter.presentations.group_by_date
  end
end
