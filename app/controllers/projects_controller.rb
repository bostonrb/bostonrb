class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @left_projects, @right_projects = @projects.halve
  end

  def show
    @project = Project.find params[:id]
  end

end
