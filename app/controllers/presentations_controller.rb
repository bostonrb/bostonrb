class PresentationsController < ApplicationController
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
      flash[:success] = 'Presentation created.'
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def update
    @presentation = Presentation.find params[:id]

    if @presentation.update_attributes(params[:presentation])
      flash[:success] = 'Presentation updated.'
      redirect_to presentation_path(@presentation)
    else
      render :action => "edit"
    end
  end

  def destroy
    @presentation = Presentation.find params[:id]
    @presentation.destroy

    flash[:success] = 'Presentation deleted.'
    redirect_to root_path
  end
end
