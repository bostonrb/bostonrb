module ClearanceHelper
  def authentication_links
    if signed_in?
      signed_in_links
    else
      signed_out_links
    end
  end

  def signed_out_links
    links = { "Sign up" => sign_up_path, "Sign in" => sign_in_path }
    links.collect { |key, value| link_to(key, value) }
  end

  def signed_in_links
    [link_to("Sign out", sign_out_path)]
  end
end
