class Admin::LocationsController < ApplicationController
  before_filter :check_for_organizer

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])

    if @location.save
      flash[:notice] = 'Created location successfully'
      redirect_to new_admin_location_path
    else
      flash[:notice] = 'Invalid information. Please try again'
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:id])
    @location.time_of_deletion = Time.now

    if @location.save
      flash[:notice] = 'Successful deletion'
      redirect_to new_admin_location_path
    end
  end

  def check_for_organizer
    raise ActionController::RoutingError.new('Not Found') unless is_organizer?
  end
end
