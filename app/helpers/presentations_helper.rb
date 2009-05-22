module PresentationsHelper

  def presentation_links(presentations)
    presentations.collect { |p| link_to(p.title, p.url) }
  end

  def parse_presenter(presentation)
    presenter = presentation.presenter
    presenter = (presenter.twitter || presenter.email) if presenter.kind_of?(User)
    presenter
  end

end
