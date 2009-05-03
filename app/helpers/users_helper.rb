module UsersHelper

  def user_name_and_tweet
    name  = html_escape("techpickles")
    tweet = html_escape("boston.rb meeting tonight, see you there.")
    "#{link_to(name, '#')} &ndash; #{tweet}"
  end

end
