class UsersController < Clearance::UsersController

  before_filter :forbid_editing_user_other_than_current_user,
    :only => [:edit, :update]
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

  def forbid_editing_user_other_than_current_user
    unless User.find(params[:id]) == current_user
      raise ActionController::Forbidden, "not current user"
    end
  end

end

