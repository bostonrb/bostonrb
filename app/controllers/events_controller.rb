class EventsController < ApplicationController
  def index
    @events = Event.next(4)
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find params[:id]
  end

  def show
    @event = Event.find params[:id]
  end

  def create
    @event = Event.new params[:event]

    if @event.save
      flash[:notice] = 'Event created.'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event updated.'
      redirect_to event_path(@event)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = 'Event deleted.'
    redirect_to root_path
  end
end
