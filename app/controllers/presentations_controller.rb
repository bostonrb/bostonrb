class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.all
  end

  def show
    @presentation = Presentation.find params[:id]
  end

  def new
    @presentation = Presentation.new
  end

  def edit
    @presentation = Presentation.find params[:id]
  end

  def create
    @presentation = Presentation.new params[:presentation]

    if @presentation.save
      flash[:notice] = 'Presentation was successfully created.'
      redirect_to presentations_url
    else
      render :action => "new"
    end
  end

  def update
    @presentation = Presentation.find params[:id]

    if @presentation.update_attributes(params[:presentation])
      flash[:notice] = 'Presentation was successfully updated.'
      redirect_to presentations_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @presentation = Presentation.find params[:id]
    @presentation.destroy

    flash[:notice] = 'Presentation was successfully deleted.'
    redirect_to presentations_url
  end
end
