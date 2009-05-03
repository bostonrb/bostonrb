module PresentationsHelper

  def sentence_of_linkable_presentations
    presentations = ["Agile Design", "Advanced Active Record",
                     "Git", "Rails/Merb Merge"]
    linkable_presentations = presentations.collect do |presentation|
      link_to presentation, "#"
    end
    linkable_presentations.to_sentence
  end

end
