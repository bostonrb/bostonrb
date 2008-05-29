class JobsController < ApplicationController
  
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html
      format.rss  { render :template => '/jobs/index' }
    end
  end

  def show
    @job = Job.find params[:id]
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find params[:id]
  end

  def create
    @job = Job.new params[:job]

    if @job.save
      flash[:notice] = 'Job was successfully created.'
      redirect_to jobs_url
    else
      render :action => "new"
    end
  end

  def update
    @job = Job.find params[:id]

    if @job.update_attributes(params[:job])
      flash[:notice] = 'Job was successfully updated.'
      redirect_to jobs_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @job = Job.find params[:id]
    @job.destroy

    flash[:notice] = 'Job was successfully deleted.'
    redirect_to jobs_url
  end
end
