module ProjectsHelper

  def project_name_and_link
    name = html_escape("Jeweler")
    link = html_escape("http://github.com/techpickles/jeweler")
    "#{name} &ndash; #{link_to(link, link)}"
  end

end
