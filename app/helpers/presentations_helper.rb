module PresentationsHelper

  def presentation_links(presentations)
    presentations.collect { |p| link_to(p.title, p.url) }
  end

end
