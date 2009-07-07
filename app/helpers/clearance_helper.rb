module ClearanceHelper
  def authentication_links
    if signed_in?
      signed_in_links
    else
      signed_out_links
    end
  end

  def signed_out_links
    [link_to("Sign up", sign_up_path),
     link_to("Sign in", sign_in_path)]
  end

  def signed_in_links
    [link_to("My Account", edit_user_path(current_user)),
     link_to("Sign out",   sign_out_path)]
  end
end
