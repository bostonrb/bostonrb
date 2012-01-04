class PostsController < ApplicationController
  def index
    @posts = Post.most_recent(:page => params[:page], :per => params[:per])

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
end
