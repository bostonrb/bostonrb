def have_event_content(event, expectation)
  page.send(expectation, have_content(event.project_night_url) )
  page.send(expectation, have_content(event.meeting_url) )
end
