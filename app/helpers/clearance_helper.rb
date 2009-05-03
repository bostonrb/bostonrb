module ClearanceHelper
  def authentication_links
    if signed_in?
      signed_in_links
    else
      signed_out_links
    end
  end

  def signed_out_links
    links = { "Sign up" => new_user_path, "Sign in" => new_session_path }
    links.collect { |key, value| link_to(key, value) }
  end

  def signed_in_links
    links = { "Sign up" => new_user_path, "Sign in" => new_session_path }
    links.collect { |key, value| link_to(key, value) }
  end
end
