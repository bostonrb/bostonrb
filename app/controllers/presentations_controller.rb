class PresentationsController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy, :show, :index

  def create
    create! { root_url }
  end

  def destroy
    destroy! { root_url }
  end
  
  protected
  
  def collection
    @presentations ||= end_of_association_chain.paginate(:page => params[:page])
  end

end
