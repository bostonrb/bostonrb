module BlogsHelper

  def post_title_and_blog_name
    post = html_escape("local code meetup inspires world peace")
    blog = html_escape("Giant Robots")
    "#{link_to(post, '#')} &ndash; #{blog}"
  end

end
