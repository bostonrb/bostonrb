class AppsController < ApplicationController

  def index
    @apps = App.all
    @left_apps, @right_apps = @apps.halve
  end

  def new
    @app = App.new
  end

  def edit
    @app = App.find params[:id]
  end

  def create
    @app = App.new params[:app]

    if @app.save
      flash[:notice] = 'App was successfully created.'
      redirect_to apps_url
    else
      render :action => 'new'
    end
  end

  def update
    @app = App.find params[:id]

    if @app.update_attributes(params[:app])
      flash[:notice] = 'App was successfully updated.'
      redirect_to apps_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy

    flash[:notice] = 'App was successfully deleted.'
    redirect_to apps_url
  end

end
