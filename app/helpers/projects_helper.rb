module ProjectsHelper

  def project_link(project)
    name = html_escape(project.name)
    link = html_escape(project.homepage_url)
    link_to name, link
  end

end
