module ProjectsHelper

  def project_name_and_description
    name        = html_escape("Jeweler")
    link        = html_escape("http://github.com/techpickles/jeweler")
    description = html_escape("Simple and opinionated helper for creating and managing Rubygem projects on GitHub")
    "#{link_to(name, link)} &ndash; #{description}"
  end

end
