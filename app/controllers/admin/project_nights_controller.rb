class Admin::ProjectNightsController < AdminController

  def index
    @project_night = ProjectNight.first || ProjectNight.new
  end

  def create
    @project_night = ProjectNight.new(params[:project_night])

    respond_to do |format|
      if @project_night.save
        format.html { redirect_to admin_project_nights_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def update
    @project_night = ProjectNight.first

    respond_to do |format|
      if @project_night.update_attributes(params[:project_night])
        format.html { redirect_to admin_project_nights_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

end
