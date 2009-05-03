module ProjectsHelper

  def linkable_project
    name = html_escape("Jeweler")
    link = html_escape("http://github.com/techpickles/jeweler")
    link_to name, link
  end

end
