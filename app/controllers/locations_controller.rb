class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:id])

    if @location.save
      flash[:notice] = 'Created location successfully'
      redirect_to new_location_path
    else
      flash[:notice] = 'Invalid information. Please try again'
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

# if @location.update
#       flash[:notice] = 'Upated location successfully'
#       redirect_to new_location_path
#     else
#       flash[:notice] = 'Invalid information. Please try again'
#       render :new
#     end
  def destroy
    @location = Location.find(params[:id])
    @location.time_of_deletion = Time.now

    if @location.save
      redirect_to new_location_path
    end
  end
end
