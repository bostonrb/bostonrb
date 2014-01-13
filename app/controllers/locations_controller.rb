class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])

    if @location.save
      flash[:notice] = 'Created location successfully'
      redirect_to new_location_path
    else
      flash[:notice] = 'Invalid information. Please try again'
      render :new
    end
  end
end
