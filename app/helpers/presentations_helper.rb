module PresentationsHelper

  def presentation_links
    presentations = ["Agile Design", "Advanced Active Record",
                     "Git", "Rails/Merb Merge"]
    presentations.collect { |presentation| link_to(presentation, "#") }
  end

end
