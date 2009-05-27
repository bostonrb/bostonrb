class EventsController < ApplicationController
  def index
    respond_to do |wants|
      wants.html { @events = Event.next(4) }
      wants.atom { @events = Event.next(10) }
      wants.rss { 
        @new_feed_url = request.url.gsub!("rss", "atom")
        @message = "Please use our Atom feed instead:<br />" +
        "<a href='#{@new_feed_url}'>#{@new_feed_url}</a>" 
      }
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
