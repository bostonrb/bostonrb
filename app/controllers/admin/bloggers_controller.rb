class Admin::BloggersController < ApplicationController
  http_basic_authenticate_with name: BostonRuby::Admin[:username], password: BostonRuby::Admin[:password]

  def index
    @bloggers = Blogger.alphabetically.page(params[:page]).per(params[:per])
  end

  def new
    @blogger = Blogger.new
  end

  def create
    @blogger = Blogger.new(params[:blogger])

    respond_to do |format|
      if @blogger.save
        format.html { redirect_to admin_bloggers_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @blogger = Blogger.find(params[:id])
  end

  def update
    @blogger = Blogger.find(params[:id])
    @submit_url = admin_blogger_path(@blogger)
    @method = :put

    respond_to do |format|
      if @blogger.update_attributes(params[:blogger])
        format.html { redirect_to admin_bloggers_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @blogger = Blogger.find(params[:id])

    respond_to do |format|
      if @blogger.destroy
        format.html { redirect_to admin_bloggers_path }
      end
    end
  end
end
