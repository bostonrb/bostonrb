class JobsController < ApplicationController

  before_filter :authorize, :only => [:edit]

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
      flash[:notice] = 'Job created.'
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def update
    @job = Job.find params[:id]

    if @job.update_attributes(params[:job])
      flash[:notice] = 'Job updated.'
      redirect_to job_path(@job)
    else
      render :action => "edit"
    end
  end

  def destroy
    @job = Job.find params[:id]
    @job.destroy

    flash[:notice] = 'Job deleted.'
    redirect_to root_path
  end

  private

  def authorize
    unless user_session.edit_job? Job.find(params[:id])
      flash[:notice] = 'Editing time expired.'
      redirect_to root_path
    end
  end

end
