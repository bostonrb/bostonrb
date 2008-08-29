class EventsController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        @upcoming_events = Event.upcoming
        @past_events = Event.past
      end
      format.rss do
        @events = Event.find :all
      end
    end
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
    if params[:captcha].blank?
      @event = Event.new params[:event]

      if @event.save
        flash[:notice] = 'Event was successfully created.'
        redirect_to events_url
      else
        render :action => 'new'
      end
    else
      redirect_to events_url
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to events_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = 'Event was successfully deleted.'
    redirect_to events_url
  end

end
