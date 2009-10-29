class JobsController < InheritedResources::Base
  actions :show, :new, :create, :edit, :update, :destroy, :index

  before_filter :authorize, :only => [:edit]

  respond_to :atom, :only => :index
  
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
  
  protected
  
  def collection
    @jobs ||= end_of_association_chain.by_created_at(:desc).paginate(:page => params[:page])
  end

end
