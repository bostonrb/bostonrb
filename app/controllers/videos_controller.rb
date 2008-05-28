class VideosController < ApplicationController
  
  def index
    @videos = Video.all
  end
  
  def show
    @video = Video.find params[:id]
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find params[:id]
  end

  def create
    @video = Video.new params[:video]

    if @video.save
      flash[:notice] = 'Video was successfully created.'
      redirect_to videos_url
    else
      render :action => "new"
    end
  end

  def update
    @video = Video.find params[:id]

    if @video.update_attributes(params[:video])
      flash[:notice] = 'Video was successfully updated.'
      redirect_to videos_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @video = Video.find params[:id]
    @video.destroy
    
    flash[:notice] = 'Video was successfully deleted.'
    redirect_to videos_url
  end
end
