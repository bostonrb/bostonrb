def have_presentation_content(presentation, expectation)
  page.send(expectation, have_content(presentation.title))
  page.send(expectation, have_content(presentation.description))
  page.send(expectation, have_content(presentation.presenter.name))
  page.send(expectation, have_css("a[href='#{presentation.slides_url}']", :text => "Slides"))
end
