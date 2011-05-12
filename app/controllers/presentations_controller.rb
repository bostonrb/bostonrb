class PresentationsController < ApplicationController

  def index
    @presentations = Presentation.group_by_date
  end
end
