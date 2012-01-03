class Admin::SettingsController < AdminController
  def index
    @settings = Setting.all
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        format.html { redirect_to admin_settings_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to admin_settings_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.destroy
        format.html { redirect_to admin_settings_path }
      end
    end
  end
end
