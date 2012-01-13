def have_blog_content(presentation, expectation)
  have_basic_blog_content(presentation, expectation)
end

def have_basic_blog_content(presentation, expectation)
  page.send(expectation, have_content(presentation.author))
  page.send(expectation, have_content(presentation.twitter_username))
  page.send(expectation, have_content(presentation.feed_url))
end
