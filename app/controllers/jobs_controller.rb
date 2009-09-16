class JobsController < InheritedResources::Base
  actions :show, :new, :create, :edit, :update, :destroy

  before_filter :authorize, :only => [:edit]

  def create
    create! { root_url }
  end

  def destroy
    destroy! { root_url }
  end

  private

  def authorize
    unless user_session.edit_job? Job.find(params[:id])
      flash[:notice] = 'Editing time expired.'
      redirect_to root_path
    end
  end

end
