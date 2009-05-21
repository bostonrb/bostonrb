class AppsController < ApplicationController

  def new
    @app = App.new
  end

  def edit
    @app = App.find params[:id]
  end

  def create
    @app = App.new params[:app]

    if @app.save
      flash[:success] = 'App created.'
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def update
    @app = App.find params[:id]

    if @app.update_attributes(params[:app])
      flash[:sucess] = 'App updated.'
      redirect_to app_path(@app)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy

    flash[:success] = 'App deleted.'
    redirect_to root_path
  end

end
