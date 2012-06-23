def have_presentation_content(presentation, expectation)
  have_basic_presentation_content(presentation, expectation)
  page.send(expectation, have_css("a[href='#{presentation.slides_url}']", :text => "Slides"))
  page.send(expectation, have_css("a[href='#{presentation.video_url}']", :text => "Video"))
end

def have_basic_presentation_content(presentation, expectation)
  page.send(expectation, have_content(presentation.title))
  page.send(expectation, have_content(presentation.description))
  presentation.presenters.each do |presenter|
    page.send(expectation, have_content(presenter.name))
  end
end
