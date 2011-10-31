class AddProjectsToPresentation < ActiveRecord::Migration
  def up
    add_column :presentations, :projects, :text
    Presentation.reset_column_information

    Presentation.all do |presentation|
      next unless presentation.project_url
      presentation.projects = {'Project' => presentation.project_url}
      presentation.save!
    end

    remove_columns(:presentations, :project_url, :project_type)
  end

  def down
    add_column :presentations, :project_url, :string
    add_column :presentations, :project_type, :string
    Presentation.reset_column_information

    Presentation.all do |presentation|
      next if presentation.projects.empty?
      presentation.project_url = presentation.projects.values.first
      presentation.save!
    end

    remove_column :presentations, :projects
  end
end
