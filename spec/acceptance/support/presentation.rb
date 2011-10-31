def have_presentation_content(presentation, expectation)
  page.send(expectation, have_content(presentation.title))
  page.send(expectation, have_content(presentation.description))
  presentation.presenters.each do |presenter|
    page.send(expectation, have_content(presenter.name))
  end
  page.send(expectation, have_css("a[href='#{presentation.slides_url}']", :text => "Slides"))
  page.send(expectation, have_css("a[href='#{presentation.projects.values.first}']", :text => "Project"))
end
