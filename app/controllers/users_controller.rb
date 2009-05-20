class UsersController < Clearance::UsersController
  skip_before_filter :authenticate, :only => [:new, :create]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated."
      redirect_to root_path
    else
      render :action => :edit
    end
  end
end

