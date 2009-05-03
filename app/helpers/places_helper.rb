module PlacesHelper

  def sentence_of_linkable_places
    places = ["thoughtbot office", "betahouse",
              "Charles Street Starbucks", "Andala Cafe",
              "1369 Cafe"]
    linkable_places = places.collect do |place|
      link_to place, "#"
    end
    linkable_places.to_sentence
  end

end
