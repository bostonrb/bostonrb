class EventTypesController < ApplicationController
  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(params[:event_type])

    if @event_type.save
      flash[:notice] = "Created successfully"
      redirect_to new_event_type_path
    else
      flash[:error] = "Invalid information. Please try again"
      render :new
    end
  end
end
