module PresentationsHelper

  def linkable_presentations
    presentations = ["Agile Design", "Advanced Active Record",
                     "Git", "Rails/Merb Merge"]
    presentations.collect do |presentation|
      link_to presentation, "#"
    end
  end

end
