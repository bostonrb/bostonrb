class ProjectsController < InheritedResources::Base
  actions :show, :index
  
  protected
  
  def collection
    @projects ||= end_of_association_chain.paginate(:page => params[:page])
  end

end
