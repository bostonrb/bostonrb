class ProjectsController < InheritedResources::Base
  actions :show, :index
  
  protected
  
  def collection
    @projects ||= end_of_association_chain.by_name(:asc).paginate(:page => params[:page])
  end

end
