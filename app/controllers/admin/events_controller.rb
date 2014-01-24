class Admin::EventsController < ApplicationController
  before_filter :check_for_authenticated_user
  

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create

    @event = Event.new(params[:event])     
    
      if !@event.event_type.nil? && @event.event_type.name == "Meeting" && !is_organizer?
        flash[:notice] = 'Project Night coordinators cannot make meeting events.'
        redirect_to new_admin_event_path
      else
        if @event.save
          flash[:notice] = 'Event successfully created'
          redirect_to new_admin_event_path
        else
          flash[:notice] = 'Invalid information. Please try again'
          render :action => "new"
        end
      end
  end

  def edit
    @event = Event.find(params[:id])
    if @event.event_type.name == 'Meeting'
      unless is_organizer?
        flash[:notice] ='Access Denied!'
        redirect_to admin_event_path(@event)
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.save                                                                                
      flash[:notice] ='Event was successfully edited!' 

      redirect_to admin_event_path(@event)                                                           
    else                                                                                             
      flash[:notice] ='Invalid input. Please try again'                                              
      render :edit
    end
  end

  private
  def check_for_authenticated_user
    raise ActionController::RoutingError.new('Not Found') unless signed_in?
  end

  def check_for_organizer
    raise ActionController::RoutingError.new('Not Found') unless is_organizer?
  end
end
