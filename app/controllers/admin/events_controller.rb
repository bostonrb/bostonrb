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

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event successfully created'
        format.html { redirect_to new_admin_event_path }
      else
        flash[:notice] = 'Invalid information. Please try again'
        format.html { render :action => "new" }
      end
    end
  end

  private
  def check_for_authenticated_user
    raise ActionController::RoutingError.new('Not Found') unless signed_in?
  end
end
