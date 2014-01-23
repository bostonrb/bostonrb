class Admin::EventTypesController < ApplicationController
  before_filter :check_for_organizer

  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(params[:event_type])
    respond_to do |format|
      if @event_type.save
        flash[:notice] = "Created successfully"
        format.html { redirect_to new_admin_event_type_path }
      else
        flash[:error] = "Invalid information. Please try again"
        format.html { render :action => "new" }
      end
    end
  end

  private
  def check_for_organizer
    raise ActionController::RoutingError.new('Not Found') unless is_organizer?
  end

end
