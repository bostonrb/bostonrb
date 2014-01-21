class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end  

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      flash[:notice] = 'Event successfully created'
      redirect_to new_event_path
    else
      flash[:notice] = 'Invalid information. Please try again'
      render :new
    end
  end
end
