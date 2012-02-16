class Admin::BlogsController < AdminController
  def index
    @blogs = Blog.alphabetically.page(params[:page]).per(params[:per])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])

    respond_to do |format|
      if @blog.save
        format.html { redirect_to admin_blogs_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @submit_url = admin_blog_path(@blog)
    @method = :put

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to admin_blogs_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.destroy
        format.html { redirect_to admin_blogs_path }
      end
    end
  end
end
