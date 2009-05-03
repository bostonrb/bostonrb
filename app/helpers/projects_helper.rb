module ProjectsHelper

  def project_link
    name = html_escape("Jeweler")
    link = html_escape("http://github.com/techpickles/jeweler")
    link_to name, link
  end

end
