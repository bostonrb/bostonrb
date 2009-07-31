class ProjectsController < InheritedResources::Base
  actions :show

  def index
    @projects = Project.all
    @left_projects, @right_projects = @projects.halve
  end

end
